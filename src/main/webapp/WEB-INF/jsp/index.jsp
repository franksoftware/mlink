<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Basic Layout - jQuery EasyUI Demo</title>
<link rel="stylesheet" type="text/css"
	href="resources/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css"
	href="resources/easyui/themes/icon.css">
<link rel="stylesheet" type="text/css" href="resources/easyui/demo.css">
<script type="text/javascript" src="resources/easyui/jquery.min.js"></script>
<script type="text/javascript"
	src="resources/easyui/jquery.easyui.min.js"></script>
</head>
<body>
	<!-- 
	<h2>mLink</h2>
	<div style="margin: 20px 0 10px 0;"></div>
	 -->
	<div class="easyui-tabs" style="width: 100%; min-height:100%;margin:0px;">
		<div title="基本数据" style="padding: 10px">
			<div class="easyui-layout" style="width: 100%; height: 800px;">
				<div data-options="region:'west',split:true" title="mlink-大洲-国家-城市-节点"
					style="width: 200px;">
					<ul class="easyui-tree" id="tt" data-options="url:'tree/getTreeMenu',method:'get',animate:true" >
					</ul>
				</div>
				
			
				<div
					data-options="region:'center',title:'Main Title',iconCls:'icon-ok'">
					<table class="easyui-datagrid" id="node_table">
					</table>
				</div>
			</div>
			
		</div>
		<div title="统计分析" style="padding: 10px"></div>
		<div title="Help" data-options="iconCls:'icon-help',closable:true"
			style="padding: 10px">This is the help content.
			
		</div>
	</div>
	
	<div id="window" class="easyui-window" title="Basic Window" data-options="iconCls:'icon-save'" style="width:500px;padding:10px;">
		 <form id="levelform">
		 	<input type="hidden" name="levelid" value="">
		 	<input type="hidden" name="levelname" value="">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="名称：" name="level_name" labelPosition="top" style="width:100%;height:52px">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="排序：" name="sort" labelPosition="top" style="width:100%;height:52px">
        </div>
         <!-- 
         <div id="nodetext" style="display: none;">
         
	        <div style="margin-bottom:20px">
	            <input class="easyui-textbox"  label="等级资质：" name="authentication" labelPosition="top" style="width:100%;height:80px" data-options="label:'Message:',multiline:true">
	        </div>
        </div>
         -->
        <div>
            <a onclick="addLevel();" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px">Submit</a>
        </div>
        </form>
	</div>
	
	<div id="nodewindow" class="easyui-window" title="Basic Window" data-options="iconCls:'icon-save'" style="width:500px;padding:10px;">
		 <form id="nodeform">
		 	<input type="hidden" name="nodeid" value="">
		 	<input type="hidden" name="nodelevel" value="">
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="名称：" name="node_name" labelPosition="top" style="width:100%;height:52px">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox" label="排序：" name="sort" labelPosition="top" style="width:100%;height:52px">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  label="总面积：" name="area" labelPosition="top" style="width:100%;height:80px" data-options="label:'Message:',multiline:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  label="服务等级协议：" name="protocol" labelPosition="top" style="width:100%;height:80px" data-options="label:'Message:',multiline:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  label="电力和冷却：" name="electricity" labelPosition="top" style="width:100%;height:80px" data-options="label:'Message:',multiline:true">
        </div>
        <div style="margin-bottom:20px">
            <input class="easyui-textbox"  label="等级资质：" name="authentication" labelPosition="top" style="width:100%;height:80px" data-options="label:'Message:',multiline:true">
        </div>
        <div>
            <a onclick="addNode();" class="easyui-linkbutton" iconCls="icon-ok" style="width:100%;height:32px">Submit</a>
        </div>
        </form>
	</div>
	
	
	<script type="text/javascript">
	$(function(){
		console.log(document.body.clientHeight);
			
		$("#nodewindow").window("close");
		$("#window").window("close");
		$("#node_table").datagrid({
			width:document.body.clientWidth-300,
			height:750,
			nowrap: true,
			autoRowHeight: false,
			striped: true,
			collapsible:true,
			singleSelect : true,
			url:'tree/getNodeList',
			sortOrder: 'desc',
			remoteSort: false,
			columns:[[ 
				{field:"name",title:"名称",width:'20%'},
				{field:"sort",title:"排序",width:'20%'},
				{field:"description",title:"描述",width:'60%'}
			]],
			pagination:true,
			rownumbers:true,
			toolbar:[{
				id:'btnedt',
				text:'添加节点',
				iconCls:'icon-edit',
				handler:function(){
					var node = $('#tt').tree('getSelected');
					if (node){
						console.log(node.text+":"+node.id+":"+node.level);
						if("city"!=node.level){
							$("#window").window("open");
							$("input[name='levelid']").val(node.id);
							$("input[name='levelname']").val(node.level);
						}else{
							$("#nodewindow").window("open");
							$("input[name='nodeid']").val(node.id);
							$("input[name='nodelevel']").val(node.level);
						}
					}
				}
			}]
		});
		
		$("#tt").tree({  
            onClick:function(node){  
                console.log(node.id+":"+node.level);
                $("#node_table").datagrid("reload",{"level":node.level,"id":node.id});
            }  
        });  
		
	});
	function addLevel(){
		$.ajax({
			url : 'tree/saveLevel',
			data : $('#levelform').serialize(),
			dataType : 'json',
			async : false,
			type : 'post',
			success : function(json) {
				if(json.result){
					var node = $('#tt').tree('getSelected');
					if(node){
						$.messager.show({
			                title:'小提示',
			                msg:'添加成功',
			                showType:'show'
			            });
						//重新加载表格
						$("#node_table").datagrid("reload",{"level":node.level,"id":node.id});
						//树形菜单加上
						console.log(json.id);
						var nodes=[{
							"id":json.id,
							"text":$("input[name='level_name']").val(),
							"level":json.level
						}];
						$('#tt').tree('append', {
							parent:node.target,
							data:nodes
						});
						//关闭窗口
						$("#window").window("close");
					}
				}else{
					$.messager.show({
		                title:'小提示',
		                msg:'添加失败',
		                showType:'show'
		            });
				}
			}
		});
	}
	
	function addNode(){
		$.ajax({
			url : 'tree/saveNode',
			data : $('#nodeform').serialize(),
			dataType : 'json',
			async : false,
			type : 'post',
			success : function(json) {
				if(json.result){
					var node = $('#tt').tree('getSelected');
					if(node){
						$.messager.show({
			                title:'小提示',
			                msg:'添加成功',
			                showType:'show'
			            });
						//重新加载表格
						$("#node_table").datagrid("reload",{"level":node.level,"id":node.id});
						//树形菜单加上
						console.log(json.id);
						var nodes=[{
							"id":json.id,
							"text":$("input[name='node_name']").val(),
							"level":json.level
						}];
						$('#tt').tree('append', {
							parent:node.target,
							data:nodes
						});
						//关闭窗口
						$("#nodewindow").window("close");
					}
				}else{
					$.messager.show({
		                title:'小提示',
		                msg:'添加失败',
		                showType:'show'
		            });
				}
			}
		});
	}
	
	</script>
</body>
</html>