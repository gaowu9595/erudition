<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Erudition</title>

    <link rel="stylesheet" href="${assetsPath}/css/app.min.css"/>
    <link rel="stylesheet" href="//cdn.bootcss.com/iCheck/1.0.1/skins/square/blue.css"/>

    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="${assetsPath}/js/jquery-accordion-menu.js"></script>
    <script src="${assetsPath}/js/icheck.js"></script>
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
</head>

<body>
<%--遮罩层--%>
<div class="mask"></div>

<jsp:include page="common/header.jsp" />
<c:set var="secondCates"/>

<div class="main flex-row">
    <div class="flex-2">
        <div class="nav">
            <div id="jquery-accordion-menu" class="jquery-accordion-menu white">
                <div id="user-image">
                    <a href=""><img src="${assetsPath}/images/user.jpg" alt="" class="img-circle"/></a>
                    <div class="user-name">${username}</div>
                </div>

                <div class="jquery-accordion-menu-header" id="form"></div>                 <!--//里面的form是动态添加的-->
                <ul id="demo-list">

                    <li class="active" ><a href="#"><i class="fa fa-home"></i>共享目录 </a>
                        <ul class="submenu" id="first-cates">
                            <c:forEach items="${categories}" var="firstCate">
                                <li><a href="#">${firstCate.name}</a>

                                    <ul class="submenu">
                                        <c:forEach items="${firstCate.children}" var="secondCate">
                                            <li><a href="#">${secondCate.name}</a>

                                                <ul class="submenu">
                                                    <c:forEach items="${secondCate.children}" var="thirdCate">
                                                        <li value="${thirdCate.id}"><a href="#">${thirdCate.name}</a></li>
                                                    </c:forEach>
                                                </ul>

                                            </li>
                                        </c:forEach>
                                    </ul>

                                </li>
                            </c:forEach>
                        </ul>

                    </li>


                        <li class="" ><a href="${rootPath}/filecollect/file"><i class="fa fa-glass"></i>常用目录 </a>
                            <ul class="submenu" >
                                <c:forEach items="${categories}" var="firstCate">
                                    <li><a href="#">${firstCate.name}</a>

                                        <ul class="submenu">
                                            <c:forEach items="${firstCate.children}" var="secondCate">
                                                <li><a href="#">${secondCate.name}</a>

                                                    <ul class="submenu">
                                                        <c:forEach items="${secondCate.children}" var="thirdCate">
                                                            <li value="${thirdCate.id}"><a href="#">${thirdCate.name}</a></li>
                                                        </c:forEach>
                                                    </ul>

                                                </li>
                                            </c:forEach>
                                        </ul>

                                    </li>
                                </c:forEach>
                            </ul>

                        </li>

                </ul>
                <div class="jquery-accordion-menu-footer">
                    Footer
                </div>
            </div>
        </div>

        <div class="clearfix"></div>
    </div>


    <div class="contents flex-8">
        <div class="header-all">
            <div class="header flex-row">
                <div class="flex-7 path">
                    根目录
                </div>
                <div class="flex-3 search">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="该目录下搜索...">
                              <span class="input-group-btn">
                                <button class="btn btn-default" type="button"><i class="fa fa-search"></i></button>
                              </span>
                    </div>
                </div>
            </div>
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
                <c:forEach var="files" items="${searchresult}">
                    <div class='body-floor flex-row'><div class='flex-3 flex-row'>
                        <div class='flex-1 checkbox'><input type='checkbox'/></div>
                        <div class='flex-1 file-image'><i class='fa fa-folder-o fa-3x'></i></div>
                        <div class='file-name flex-4'><span><a href='#'>${files.title}</a></span></div></div>
                        <div class='flex-3 file-size'><span>1.27MB</span></div>
                        <div class='flex-3 file-creator'>${files.creater}</div>
                        <div class='flex-3 file-time'>${files.createTime}</div>
                    </div>
                    <div class='line'></div>
                </c:forEach>

            </div>

        </div>
    </div>

</div>

<!--文件弹窗-->

<div class="file-out">
    <div class="pre-btn"></div>
    <!--<div class="clearfix"></div>-->
    <div class="file-body" id="file-info">
        <%--<div class="content">--%>
            <%--<div class="file">--%>
                <%--<div class="file-thumbnails">--%>
                    <%--<div class="file-name">SQLdb_ilearn_3</div>--%>
                    <%--<div class="file-class">文件类型SQL</div>--%>
                <%--</div>--%>
                <%--<div class="file-size">--%>
                    <%--<button class="download">下载文件(4MB)</button>--%>
                <%--</div>--%>
            <%--</div>--%>
        <%--</div>--%>

        <%--<div class="attribute">--%>
            <%--<div class="a-info">--%>
                <%--<div class="a-first">--%>
                    <%--<div class="file-from">所属文件夹:数据库</div>--%>
                    <%--<div class="a-close">×</div>--%>
                    <%--<div class="clearfix"></div>--%>
                <%--</div>--%>
                <%--<div class="file-name">SQLdb_ilearn_3</div>--%>
                <%--<div class="collected">收藏量&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2333</div>--%>
                <%--<div class="a-third">--%>
                    <%--<div class="file-uptime"><i class="fa fa-clock-o"></i>2013-12-12</div>--%>
                    <%--<div class="file-people"><i class="fa fa-user"></i>上传人-MR.Z</div>--%>
                <%--</div>--%>
            <%--</div>--%>
            <%--<div class="line"></div>--%>
            <%--<div class="a-operate">--%>
                <%--<ul>--%>
                    <%--<li><a href="#"><i class="fa fa-download"></i>&nbsp;&nbsp;下载</a></li>--%>
                    <%--<li><a href="#"><i class="fa fa-star"></i>&nbsp;&nbsp;收藏</a></li>--%>
                <%--</ul>--%>
            <%--</div>--%>
            <%--<div class="line"></div>--%>
            <%--<div class="a-related">--%>
                <%--<ul>--%>
                    <%--<li><a href="#"><i class="fa fa-link"></i>&nbsp;&nbsp;&nbsp;关联内容</a></li>--%>
                    <%--<c:forEach items="${relationalresources}" var="re">--%>
                        <%--<li><a href="#"><i class="fa fa-link"></i>&nbsp;&nbsp;&nbsp;${re.title}</a></li>--%>
                    <%--</c:forEach>--%>
                    <%--<li><a href="#"><i class="fa fa-tag"></i>&nbsp;&nbsp;&nbsp;标签</a></li>--%>
                <%--</ul>--%>
            <%--</div>--%>
        <%--</div>--%>
    </div>
    <div class="next-btn"></div>
    <!--<div class="clearfix"></div>-->
</div>



<%--根据三级目录显示文件--%>
<script>
    $(function(){

        $("#demo-list li").click(function(){
                    var third_cate_id = $(this).attr("value");
                    if(third_cate_id != null){
                        console.log(third_cate_id);
                        var file_list = $("#file-list");
                        var url = "/erudition/resources/"+third_cate_id+"/1";

                        file_list.empty();
                        var obj0= "<div class='first-floor flex-row'><div class='flex-3'><div>"+
                                "<input type='checkbox'/><span class='filename'>名称</span></div></div>"+
                                "<div class='flex-3'>大小</div><div class='flex-3'>创建者</div>"+
                                "<div class='flex-3'>更新日期</div></div><div class='line'></div>";
                        file_list.append(obj0);


                        $.getJSON(url , function(data){

                            $.each(data.list,function(i, file){
                                 var obj = "<div class='body-floor flex-row'><div class='flex-3 flex-row'>"+
                                        "<div class='flex-1 checkbox'><input type='checkbox'/></div>"+
                                        "<div class='flex-1 file-image'><i class='fa fa-folder-o fa-3x'></i></div>"+
                                        "<div class='file-name flex-4'><span><a href='#'>"+file.title+"</a></span></div></div>"+
                                        "<div class='flex-3 file-size'><span>1.27MB</span></div>"+
                                        "<div class='flex-3 file-creator'>"+file.creater+"</div><div class='flex-3 file-time'>"+
                                        ""+file.createTime+"</div></div><div class='line'></div>";


                                console.log(file.title);
                                file_list.append(obj);
                            });
                        });
                    }

                }

        )

    })


</script>





<%--左侧导航基础模板--%>
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


<!--动态创建搜索表单-->
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
</script>


<!--文件弹窗点击事件，静态DOM-->
<script>
    $(function(){
        $(document).on("click",".body-floor .file-name span",function(event){
            event.stopPropagation();
            $.ajax({
                url:'${rootPath}/resources/file/1',
                type:'get',
                data:'merName='+'${val}',
                async : false, //默认为true 异步
                success:function(data){
                    loadFileInfo(data.file , data.relationfiles);
                    $(".mask").fadeIn();
                    $(".file-out").fadeIn();
                },error:function(){
                    alert("error");
                }
            });

        })

        function loadFileInfo(file,relationfiles){
            var file_body = $("#file-info");
            file_body.empty();
            //alert("loadFileInfo ing!");

            var obj = "<div class='content'><div class='file'><div class='file-thumbnails'>"
                    + "<div class='file-name'>"+file.title+"</div><div class='file-class'>"
                    + file.type+"</div></div><div class='file-size'><button class='download'>下载文件("
                    + file.size+"MB)</button></div></div></div><div class='attribute'>"
                    + "<div class='a-info'><div class='a-first'><div class='file-from'>所属文件夹:"
                    + file.categoryName+"</div><div class='a-close'>×</div><div class='clearfix'></div>"
                    + "</div><div class='file-name'>"+file.title+"</div><div class='a-third'>"
                    + "<div class='file-uptime'><i class='fa fa-clock-o'></i>"+file.createTime
                    + "</div><div class='file-people'><i class='fa fa-user'></i>"+file.creater
                    + "</div></div></div><div class='line'></div><div class='a-operate'><ul>"
                    + "<li><a href='#'><i class='fa fa-download'></i>&nbsp;&nbsp;下载</a></li>"
                    + "<li><a href='#'><i class='fa fa-star'></i>&nbsp;&nbsp;添加至常用目录</a></li>"
                    + "</ul></div><div class='line'></div><div class='a-related'><ul>"
                    + "<li><a href='#'><i class='fa fa-link'></i>&nbsp;&nbsp;&nbsp;关联内容</a></li>";

            for(var i=0 ; i < relationfiles.length ; i++){
                var re = relationfiles[i].title;
                console.log('re= '+re);
                obj = obj + '<li><a href="#"><i class="fa fa-link"></i>&nbsp;&nbsp;&nbsp;'+
                            relationfiles[i].title+'</a></li>';
                console.log(obj);
            }

            obj = obj + "</ul></div></div>";

            file_body.append(obj);

        }



        $(".a-close").on("click",function(event){
            event.stopPropagation();
            $(".file-out").fadeOut();
            $(".mask").fadeOut();
        })

        $(".mask").on("click",function(event){
            event.stopPropagation();
            $(".file-out").fadeOut();
            $(".mask").fadeOut();
        })
    })
</script>
</body>
</html>