 var single = function() {
			return {
				init : function() {
					console.log(document.body.clientHeight);
					$("#single_table").datagrid({
						width:document.body.clientWidth-300,
						height:750,
						nowrap: true,
						autoRowHeight: false,
						striped: true,
						collapsible:true,
						singleSelect : true,
						url:'single/getSingleList',
						sortOrder: 'desc',
						remoteSort: false,
						columns:[[ 
							{field:"area",title:"总面积",width:'10%'},
							{field:"protocol",title:"服务等级协议",width:'30%'},
							{field:"electricity",title:"电力和冷却",width:'30%'},
							{field:"authentication",title:"等级资质",width:'30%'}
						]],
						pagination:true,
						rownumbers:true,
						toolbar:[{
							id:'btnedt',
							text:'添加节点信息',
							iconCls:'icon-edit',
							handler:function(){
								var node = $('#single').tree('getSelected');
								if (node){
										console.log(node.text+":"+node.id+":"+node.level);
										if("node"==node.level){
											$("#singlewindow").window("open");
											$("input[name='single_nodeid']").val(node.id);
										}else{
											$.messager.show({
								                title:'警告',
								                msg:':)',
								                showType:'show'
								            });
										}
								}
							}
						}]
					});
					
					$("#single").tree({
						url:"single/getTreeMenu",
						method:"get",
						animate:"true",
						lines:true,
			            onClick:function(node){  
			                console.log(node.id+":"+node.level);
			                $("#single_table").datagrid("reload",{"level":node.level,"id":node.id});
			            }  
			        });  
				},
	
				addSingle:function(){
					$.ajax({
						url : 'single/saveSingle',
						data : $('#singleform').serialize(),
						dataType : 'json',
						async : false,
						type : 'post',
						success : function(json) {
							if(json.result){
								var node = $('#single').tree('getSelected');
								if(node){
									$.messager.show({
						                title:'小提示',
						                msg:'添加成功',
						                showType:'show'
						            });
									//重新加载表格
									$("#single_table").datagrid("reload",{"level":node.level,"id":node.id});
									//树形菜单加上
									console.log(json.id);
								
									//关闭窗口
									$("#singlewindow").window("close");
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
		};
	}();