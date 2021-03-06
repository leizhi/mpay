package com.mooo.mycoz.action.admin;

import java.io.BufferedWriter;
import java.io.FileOutputStream;
import java.io.OutputStreamWriter;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.mooo.mycoz.action.BaseSupport;
import com.mooo.mycoz.db.MultiDBObject;
import com.mooo.mycoz.db.Transaction;
import com.mooo.mycoz.dbobj.wineBranch.GroupMember;
import com.mooo.mycoz.dbobj.wineBranch.StoreUser;
import com.mooo.mycoz.dbobj.wineBranch.User;
import com.mooo.mycoz.dbobj.wineShared.Branch;
import com.mooo.mycoz.dbobj.wineShared.BranchCategory;
import com.mooo.mycoz.dbobj.wineShared.Store;
import com.mooo.mycoz.framework.ActionSession;
import com.mooo.mycoz.framework.component.JRUtil;
import com.mooo.mycoz.framework.component.JRExport;
import com.mooo.mycoz.framework.component.Page;
import com.mooo.mycoz.framework.util.IDGenerator;
import com.mooo.mycoz.framework.util.ParamUtil;
import com.mooo.mycoz.common.StringUtils;

public class UserAction extends BaseSupport {

	private static Log log = LogFactory.getLog(UserAction.class);

	public String listUser(HttpServletRequest request,HttpServletResponse response) {
		String physicalPath = request.getSession().getServletContext().getRealPath("/");
		//报表参数
		String reportName="Users";

		Vector<String> colName = new Vector<String>();
		Vector<String> colSum = new Vector<String>();
		Vector<Integer> colWidth = new Vector<Integer>();
		
		String value = null;
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		Integer sessionId = ActionSession.getInteger(request, ActionSession.USER_SESSION_KEY);
		try {
			request.setAttribute("reportName", reportName);

			value="编号";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="名称";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="别名";
			colName.add(value);colWidth.add(StringUtils.length(value));
			value="激活";
			colName.add(value);colWidth.add(StringUtils.length(value));
			
			request.setAttribute("categorys", ActionSession.getBranchCategoryValues(request));

			StringBuilder buffer = new StringBuilder();
			buffer.append("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n");
			buffer.append("<Reports>\n");
			
			MultiDBObject dbobject = new MultiDBObject();
			dbobject.addTable(User.class, "user");
			dbobject.addTable(Branch.class, "branch");
			dbobject.addTable(BranchCategory.class, "branchCategory");

			dbobject.setForeignKey("user", "branchId", "branch", "id");
			dbobject.setForeignKey("branch", "categoryId", "branchCategory", "id");

			value = request.getParameter("categoryId");
			if(!StringUtils.isNull(value))
				dbobject.setField("branchCategory", "id", new Integer(value));
			
			value = request.getParameter("userName");
			if(!StringUtils.isNull(value))
				dbobject.setLike("user", "name", value);
			
			value = request.getParameter("userAlias");
			if(!StringUtils.isNull(value))
				dbobject.setLike("user", "alias", value);
			
			value = request.getParameter("active");
			if(!StringUtils.isNull(value))
				dbobject.setLike("user", "active", value);
			
			if(sessionId>1 && branchId!=null){
				dbobject.setField("branch","id", branchId);
			}
			
			dbobject.setRetrieveField("user", "id");
			dbobject.setRetrieveField("user", "name");
			dbobject.setRetrieveField("user", "alias");
			dbobject.setRetrieveField("user", "active");
			dbobject.setRetrieveField("user", "mobile");
			dbobject.setRetrieveField("branch", "definition");
			dbobject.setRetrieveField("branchCategory", "definition");

			dbobject.setOrderBy("user", "id");
			
			Page page = new Page();
			page.buildComponent(request, dbobject.count());
			
			dbobject.setRecord(page.getOffset(),page.getPageSize());
			
			if (log.isDebugEnabled())log.debug("SQL:"+dbobject.searchSQL());

			List<?> results = dbobject.searchAndRetrieveList();
			
			for(Object orow:results){
				buffer.append("<Rows>\n");
				Map<?,?> rowm = (Map<?,?>)orow;
				
				User user = (User)rowm.get("user");

				//column start
				value=user.getId()+"";
				if(value.length()>colWidth.get(0)){
					colWidth.set(0, StringUtils.length(value));
				}
				buffer.append("<Key0>"+value+"</Key0>\n");

				//column start
				value=user.getName();
				if(value==null) value="";
				if(value.length()>colWidth.get(1)){
					colWidth.set(1, StringUtils.length(value));
				}
				
				buffer.append("<Key1>"+value+"</Key1>\n");
				
				//column start
				value=user.getAlias();
				if(value==null) value="";
				if(value.length()>colWidth.get(2)){
					colWidth.set(2, StringUtils.length(value));
				}
				
				buffer.append("<Key2>"+value+"</Key2>\n");
				
				//column start
				value=user.getActive();
				if(value==null) value="";
				if(value.length()>colWidth.get(3)){
					colWidth.set(3, StringUtils.length(value));
				}
				
				buffer.append("<Key3>"+value+"</Key3>\n");
				
				//put data
				buffer.append("</Rows>\n");
			}
			request.setAttribute("results", results);
			
			buffer.append("</Reports>\n");
			
			String filePrefix=physicalPath+"tmp/"+reportName;
			
			FileOutputStream writerStream = new FileOutputStream(filePrefix+".xml");
			BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(writerStream, "UTF-8"));      
			writer.write(buffer.toString());
			writer.flush();
			writer.close();
			writerStream.close();
			
			String jrxml = JRUtil.createJRXML(reportName, "源酒产业联盟", "业务报表", colName, colSum, colWidth, "/Reports/Rows");
			writerStream = new FileOutputStream(filePrefix+".jrxml");
			writer = new BufferedWriter(new OutputStreamWriter(writerStream, "UTF-8")); 
			writer.write(jrxml.toString());
			writer.flush();
			writer.close();
			writerStream.close();
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			e.fillInStackTrace();
		}
		
		return "success";
	}
	
	public String promptAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptAdd");
		
		try {
			request.setAttribute("branchs", ActionSession.getBranchValues(request));
			
			User user = new User();
			ParamUtil.bindData(request, user,"user");
			
			request.setAttribute("user", user);

			Store store = new Store();
			store.setGreater("id", 0);
			
			request.setAttribute("stores", store.searchAndRetrieveList());
			
		} catch (Exception e) {
			e.printStackTrace();
		}

		return "success";
	}
	
	public String processAdd(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processAdd");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			User user = new User();
			ParamUtil.bindData(request, user,"user");
			
			user.setId(IDGenerator.getNextID(tx.getConnection(),User.class));
			user.setPassword(StringUtils.hash(user.getPassword()));

			user.add(tx.getConnection());
			
			
			String[] storeId =  request.getParameterValues("storeId");

			if(storeId!=null && storeId.length>0){
				for(int i=0;i<storeId.length;i++){
					Integer id = new Integer(storeId[i]);
					
					StoreUser storeUser = new StoreUser();
					storeUser.setId(IDGenerator.getNextID(tx.getConnection(), StoreUser.class));
					storeUser.setUserId(user.getId());
					storeUser.setStoreId(id);
					
					storeUser.add(tx.getConnection());
				}
			}
			
			tx.commit();

			request.setAttribute("message", "processAdd successfully");
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());

			return "promptAdd";
		} finally {
			tx.end();
		}
		
		return "listUser";
	}
	
	public String processDelete(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				Integer userId = new Integer(ids[i]);
				
				StoreUser storeUser = new StoreUser();
				storeUser.setUserId(userId);

				List<Object> stores = storeUser.searchAndRetrieveList(tx.getConnection());
				for(Object bean:stores){
					storeUser=(StoreUser)bean;
					storeUser.delete(tx.getConnection());
				}
				
				User user = new User();
				user.setId( userId);
				user.delete(tx.getConnection());
			}
			
			tx.commit();
			
			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			tx.rollback();
			
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "listUser";
	}
	
	public String promptEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("promptEdit");
		String userId = null;
		try {
			userId =  request.getParameter("id");
			
			if(userId==null)
				throw new Exception("Please chose object");
			
			request.setAttribute("branchs", ActionSession.getBranchValues(request));

			User user = new User();
			user.setId( new Integer(userId));
			user.retrieve();
			
			request.setAttribute("user", user);
			
			Store store = new Store();
			store.setGreater("id", 0);
			request.setAttribute("stores", store.searchAndRetrieveList());
			
			StoreUser storeUser = new StoreUser();
			storeUser.setUserId(user.getId());
			request.setAttribute("nowStores", storeUser.searchAndRetrieveList());

		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		}
		return "success";
	}
	
	public String processEdit(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("processEdit");
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			User user = new User();
			ParamUtil.bindData(request, user,"user");
			
			if(user.getPassword().length()<32)
				user.setPassword(StringUtils.hash(user.getPassword()));
			
			user.update(tx.getConnection());
			
			String[] storeId =  request.getParameterValues("storeId");

			if(storeId!=null){
				for(int i=0;i<storeId.length;i++){
					StoreUser storeUser = new StoreUser();
					storeUser.setStoreId(new Integer(storeId[i]));
					storeUser.setUserId(user.getId());
					
					if(storeUser.count()<1){
						storeUser.setId(IDGenerator.getNextID(tx.getConnection(),StoreUser.class));
						storeUser.add(tx.getConnection());
					}
				}
				
				StoreUser storeUser = new StoreUser();
				storeUser.setUserId(user.getId());
				
				List<Object> stores = storeUser.searchAndRetrieveList(tx.getConnection());
				for(Object bean:stores){
					storeUser=(StoreUser)bean;

					boolean remove = false;
					
					for(int i=0;i<storeId.length;i++){
						int dId = new Integer(storeId[i]); 
						
						if(dId==storeUser.getStoreId()){
							remove = true;
							break;
						}
					}
					
					if(!remove){
						storeUser.delete(tx.getConnection());
					}
				}
			}else{//delete all
				StoreUser storeUser = new StoreUser();
				storeUser.setUserId(user.getId());
				
				List<Object> stores = storeUser.searchAndRetrieveList(tx.getConnection());
				for(Object bean:stores){
					storeUser=(StoreUser)bean;
					storeUser.delete(tx.getConnection());
				}
			}
			
			tx.commit();
			
			request.setAttribute("message", "Modified successfully");
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "promptEdit";
		}finally {
			tx.end();
		}
		return "listUser";
	}
	
	public String export(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String print(HttpServletRequest request,HttpServletResponse response) {
		return JRExport.buildJasper(request, response);
	}
	
	public String promptAssignGroup(HttpServletRequest request,HttpServletResponse response) {
		String userId = null;
		try {
			userId =  request.getParameter("id");
			
			if(userId==null)
				throw new Exception("Please chose object");
			
			User user = new User();
			user.setId( new Integer(userId));
			user.retrieve();
			
			request.setAttribute("userName", user.getName());
			request.setAttribute("userId", user.getId());

			request.setAttribute("workGroups", ActionSession.getGroupValues(request));
			
			GroupMember groupMember = new GroupMember();
			groupMember.setUserId(new Integer(userId));
			request.setAttribute("groupMembers", groupMember.searchAndRetrieveList());
			
		} catch (Exception e) {
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
			
			return "listUser";
		}
		return "success";
	}
	
	public String processAssignGroup(HttpServletRequest request,HttpServletResponse response) {
		
		if (log.isDebugEnabled()) log.debug("processEditGroupMember");
		
		Integer branchId = ActionSession.getInteger(request, ActionSession.BRANCH_SESSION_KEY);
		String userId = null;
		String groupId[] = null;
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			userId = request.getParameter("id");
			groupId = request.getParameterValues("groupId");
			
			if(userId !=null){
				
				if(groupId!=null){
					for(int i=0;i<groupId.length;i++){
						GroupMember groupMember = new GroupMember();
						groupMember.setUserId(new Integer(userId));
						groupMember.setGroupId(new Integer(groupId[i]));
						groupMember.setBranchId(branchId);
						
						if(groupMember.count()<1){
							groupMember.setId(IDGenerator.getNextID(tx.getConnection(),GroupMember.class));
							groupMember.add(tx.getConnection());
						}
					}
					
					GroupMember groupMember = new GroupMember();
					groupMember.setUserId(new Integer(userId));
					groupMember.setBranchId(branchId);
					
					List<Object> ogroupMembers = groupMember.searchAndRetrieveList(tx.getConnection());
					for(Object bean:ogroupMembers){
						groupMember=(GroupMember)bean;
	
						boolean remove = false;
						
						for(int i=0;i<groupId.length;i++){
							int dId = new Integer(groupId[i]); 
							
							if(dId==groupMember.getGroupId()){
								remove = true;
								break;
							}
						}
						
						if(!remove){
							groupMember.delete(tx.getConnection());
						}
					}
				}else{//delete all
					GroupMember groupMember = new GroupMember();
					groupMember.setUserId(new Integer(userId));
					groupMember.setBranchId(branchId);

					List<Object> ogroupMembers = groupMember.searchAndRetrieveList(tx.getConnection());
					for(Object bean:ogroupMembers){
						groupMember=(GroupMember)bean;
						groupMember.delete(tx.getConnection());
					}
				}
			}
			
			tx.commit();
		} catch (Exception e) {
			tx.rollback();
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "promptAssignGroup";
	}
	
	public String processDisable(HttpServletRequest request, HttpServletResponse response) {
		if (log.isDebugEnabled())log.debug("SetupAction list");
		
		Transaction tx=new Transaction();
		try {
			tx.start();
			
			String[] ids =  request.getParameterValues("id");
			
			if(ids==null)
				throw new Exception("Please select delete object");
			
			for(int i=0;i<ids.length;i++){
				Integer userId = new Integer(ids[i]);
				
				User user = new User();
				user.setId(userId);
				user.setActive("N");
				
				user.update(tx.getConnection());
			}
			
			tx.commit();
			
			request.setAttribute("message", "processDelete successfully");
		} catch (Exception e) {
			tx.rollback();
			
			if (log.isDebugEnabled()) log.debug("Exception Load error of: " + e.getMessage());
			request.setAttribute("error", e.getMessage());
		} finally {
			tx.end();
		}
		return "listUser";
	}
}
