<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>文件管理</title>
</head>
<link rel="stylesheet" href="${assetsPath}/css/app.min.css"/>

<link rel="stylesheet" href="//cdn.bootcss.com/iCheck/1.0.1/skins/square/blue.css"/>
<!--<link rel="stylesheet" href="./css/square/blue.css"/>-->
<!--<link rel="stylesheet" href="//cdn.bootcss.com/iCheck/1.0.2/skins/flat/blue.css"/>-->

<script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
<script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
<script src="${assetsPath}/js/jquery-accordion-menu.js"></script>
<script src="${assetsPath}/js/icheck.js"></script>
<script src="${assetsPath}/js/template.js"></script>


<style type="text/css">
    *{box-sizing:border-box;-moz-box-sizing:border-box;-webkit-box-sizing:border-box;}
    body{background:#f0f0f0;}
    /*.content{width:260px;margin:100px auto;}*/
    .filterinput{
        background-color:rgba(249, 244, 244, 0);
        border-radius:15px;
        width:90%;
        height:30px;
        border:thin solid #FFF;
        text-indent:0.5em;
        font-weight:bold;
        color:#FFF;
    }
    #demo-list a{
        overflow:hidden;
        text-overflow:ellipsis;
        -o-text-overflow:ellipsis;
        white-space:nowrap;
        width:100%;
    }
</style>

<script type="text/javascript">
    jQuery(document).ready(function () {
        jQuery("#jquery-accordion-menu").jqueryAccordionMenu();   //启用插件   jQuery等同于$

    });

    $(function(){
        //顶部导航切换
        $("#demo-list li").click(function(){
            $("#demo-list li.active").removeClass("active")
            $(this).addClass("active");
        })
    })
</script>

<body>
<div class="mask"></div>

<jsp:include page="../common/header.jsp" />

<div class="main flex-row">


    <jsp:include page="../common/admin_sidebar.jsp" />

    <div class="contents flex-8 file-collect">
        <div class="catalog">
            <a href="${rootPath}/admin/filecollect">根目录</a>
            <c:if test="${cateLayer==1}">
                <span>/</span>
                <a href="${rootPath}/admin/filecollect/category/${cate1}">${cate1name}</a>
            </c:if>
            <c:if test="${cateLayer==2}">
            <span>/</span>
            <a href="${rootPath}/admin/filecollect/category/${cate1}">${cate1name}</a>
            <span>/</span>
            <a href="${rootPath}/admin/filecollect/category/${cate2}">${cate2name}</a>
            </c:if>
            <c:if test="${cateLayer==3}">
                <span>/</span>
                <a href="${rootPath}/admin/filecollect/category/${cate1}">${cate1name}</a>
                <span>/</span>
                <a href="${rootPath}/admin/filecollect/category/${cate2}">${cate2name}</a>
                <span>/</span>
                <a href="${rootPath}/admin/filecollect/category/${cate3}">${cate3name}</a>
            </c:if>
        </div>
        <div class="button-group" style="">
            <button class="carrynews">创建新文件夹</button>
            <%--<button class="removeall">清空文件夹</button>--%>
            <button class="remove" id="removebutton">删除文件夹</button>
        </div>
        <div  class="alldom">
            <ul id="divall">
                <c:if test="${cateLayer!=3}">                                       <%--全都写在了一个页面当中，难改--%>
                <c:forEach var="cate" items="${adminCates}">
                    <li ondblclick="openFile(${cate.id})" data-id=${cate.id}>
                        <form action="${rootPath}/admin/filecollect/changename" method="post">
                            <input type="text" name="newname" class="changename" value="${cate.categoryName}"/>
                            <input type="hidden" name="cateid" value="${cate.id}"/>
                            <c:if test="${cateLayer==0}"><input type="hidden" name="parentcateid" value="0"/></c:if>
                            <c:if test="${cateLayer==1}"><input type="hidden" name="parentcateid" value="${cate1}"/></c:if>
                            <c:if test="${cateLayer==2}"><input type="hidden" name="parentcateid" value="${cate2}"/></c:if>
                            <c:if test="${cateLayer==3}"><input type="hidden" name="parentcateid" value="${cate3}"/></c:if>

                        </form>
                    </li>
                </c:forEach>
                </c:if>

                <c:if test="${cateLayer==3}">
                    <%--<div class="contents flex-8">--%>
                        <div class="header-all">
                            <div class="file-body" id="file-list">

                                <div class="first-floor flex-row">
                                    <div class="flex-3">
                                        <div>
                                            <input type="checkbox"/>
                                            <span class="filename">名称</span>
                                        </div>
                                    </div>
                                    <div class="flex-3">大小</div>
                                    <div class="flex-3">创建者</div>
                                    <div class="flex-3">更新日期</div>
                                </div>
                                <div class="line"></div>

                                <c:forEach var="files" items="${adminCates.list}">
                                    <div class='body-floor flex-row'>
                                        <div class='flex-3 flex-row'>
                                            <div class='flex-1 checkbox'>
                                                <input type='checkbox'/>
                                            </div>
                                            <div class='flex-1 file-image'>
                                                <c:choose>
                                                <c:when test="${files.type=='docx'}"><i class="iconfont icon-word"></i></c:when>
                                                <c:otherwise><i class="iconfont icon-${files.type}"></i></c:otherwise>
                                                </c:choose>
                                            </div>
                                            <div class='file-name flex-4'>
                                                <span id="${files.id}"><a href='#'>${files.title}</a></span>
                                            </div>
                                        </div>
                                        <div class='flex-3 file-size'>
                                            <span>${files.size}</span>
                                        </div>
                                        <div class='flex-3 file-creator'>${files.creater}</div>
                                        <div class='flex-3 file-time'>${files.createTime}</div>
                                    </div>
                                    <div class='line'></div>
                                </c:forEach>

                            </div>
                        </div>

                    <%--</div>--%>

                </c:if>
            </ul>
            <c:if test="${cateLayer==3}">
                <div class="clearfix"></div>
                <%--<nav>--%>
                    <%--<ul class="pagination pull-right">--%>
                        <%--<li><a href="#">上一页</a></li>--%>
                        <%--<li class="active"><a href="#">1</a></li>--%>
                        <%--<li><a href="#">2</a></li>--%>
                        <%--<li><a href="#">3</a></li>--%>
                        <%--<li><a href="#">4</a></li>--%>
                        <%--<li><a href="#">5</a></li>--%>
                        <%--<li>--%>
                            <%--<a href="#">下一页</a>--%>
                        <%--</li>--%>
                    <%--</ul>--%>
                <%--</nav>--%>
            </c:if>
        </div>

        <div style=" clear:both;"></div>

        <div class="menu-zdy" id="menu">

            <div class="menu-one">
                <a href="#nogo" id="changename">修改文件夹名称</a>
            </div>

            <div class="menu-two">
                <a href="#nogo" id="removethispc">删除此文件</a>
            </div>

        </div>
    </div>

    <!--<div class="clearfix"></div>-->
</div>




<script>
    function openFile(cateId){
        window.location.href = "/erudition/admin/filecollect/category/"+cateId;
    }

</script>




<!--//动态创建搜索表单-->
<script type="text/javascript">
    (function($) {

        //@header 头部元素
        //@list 无需列表
        //创建一个搜素表单
        function filterList(header, list) {
            var form = $("<form>").attr({
                "class":"filterform",
                action:"#"
            }), input = $("<input>").attr({
                "class":"filterinput",
                type:"text"
            });
            $(form).append(input).appendTo(header);
            $(input).change(function() {              //过滤器的具体效果
                var filter = $(this).val();
                if (filter) {
                    $matches = $(list).find("a:Contains(" + filter + ")").parent();
                    $("li", list).not($matches).slideUp();
                    $matches.slideDown();
                } else {
                    $(list).find("li").slideDown();
                }
                return false;
            }).keyup(function() {           //用来监听键盘的效果的
                $(this).change();
            });
        }

        $(function() {                     //最先运行
            filterList($("#form"), $("#demo-list"));
        });

    })(jQuery);
</script>

<!--icheck    radio不能正常使用-->
<script>
    $(document).ready(function(){
        $('input').iCheck({
            checkboxClass: 'icheckbox_square-blue',
            radioClass: 'iradio_square-blue',
            increaseArea: '20%' // optional

        });
    });

    $(function(){
        $(".carrynews").fadeIn();
    })
</script>


<%--这里极度需要重构！！！！！！--%>
<!--弹出窗模板模板-->
<script id="popwin-template" type="text/html" charset="utf-8">


    <div class="mask"></div>
    <div class="popwin">
        <div class="header">
            <div class="title">信息</div>
            <div class="close popclose">×</div>
        </div>
        <div class="body">
            <form action="${rootPath}/admin/filecollect/newcate" method="post">
            <div class="input">
                <div class="input-primary">
                        <label>新建文件名:</label>
                        <input type="text" name="catename" placeholder="文件名..." />
                        <c:if test="${cateLayer==0}">
                            <input type="hidden" name="cate1" value="0"/>
                            <input type="hidden" name="cate2" value="-1"/>
                            <input type="hidden" name="cate3" value="-1"/>
                        </c:if>
                        <c:if test="${cateLayer==1}">
                            <input type="hidden" name="cate1" value="${cate1}"/>
                            <input type="hidden" name="cate2" value="0"/>
                            <input type="hidden" name="cate3" value="-1"/>
                        </c:if>
                        <c:if test="${cateLayer==2}">
                            <input type="hidden" name="cate1" value="${cate1}"/>
                            <input type="hidden" name="cate2" value="${cate2}"/>
                            <input type="hidden" name="cate3" value="0"/>
                        </c:if>
                </div>
            </div>
            <div class="button-group">
                <button class="cancel pull-right">取消</button>
                <input type="submit" class="confirm pull-right" value="确定"/>
                <div class="clearfix"></div>
            </div>
            </form>
        </div>
    </div>
</script>

<script src="${assetsPath}/js/file-view.js" charset="utf-8"></script>

<%--完整弹出插件--%>
<script src="${assetsPath}/js/popwinAll.js" charset="utf-8"></script>
<script src="${assetsPath}/js/file_show.js" charset="utf-8"></script>
<script>
    $(function () {
        var fileout=new FileOut();
    })
</script>
</body>
</html>