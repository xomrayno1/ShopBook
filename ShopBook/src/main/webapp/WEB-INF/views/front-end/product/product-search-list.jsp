<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

        <div class="breadcrumb-area gray-bg">
            <div class="container">
                <div class="breadcrumb-content">
                    <ul>
                        <li><a href="index.html">Home</a></li>
                        <li class="active">Shop Grid Style </li>
                    </ul>
                </div>
            </div>
        </div>       
        <div class="shop-page-area  pb-100">
            <div class="container">
                <div class="row flex-row-reverse">
                    <div class="col-lg-9">
                        <div class="shop-topbar-wrapper">
                            <div class="shop-topbar-left">
                                <p>Showing ${pageInfo.offSet + 1} - ${pageInfo.numberPerPage} of ${pageInfo.totalProduct} results  </p>
                            </div>                           
	                            <div class="product-sorting-wrapper">                                
		                                <div class="product-shorting shorting-style">
		                                   <label>Sắp xếp theo :</label>
				                                 <select id="sort" name="sort" form="searchForm">
			                                        <option value="moi-nhat">Mới nhất</option>
			                                        <option value="gia-tang">Giá thấp - cao</option>
			                                        <option value="gia-giam">Giá cao - thấp</option>
			                               </select>                
		                                </div>
	                            </div>
                        </div>
                        <div class="grid-list-product-wrapper">
                            <div class="product-grid product-view pb-20">
                                <div class="row">
                                   <c:forEach items="${listProduct}" var="product">
                                   		 <div class="product-width col-xl-3 col-lg-3 col-md-3 col-sm-6 col-12 mb-30">
	                                        <div class="product-wrapper">
	                                            <div class="product-img">
	                                                <a href='<c:url value="/${product.url}"></c:url>'>
	                                                    <img src='<c:url value="${product.imgUrl}"></c:url>' alt="">
	                                                </a>
	                                            </div>
	                                            <div class="product-content">
		                                            <div class="pro-action-left">
		                                                <a title="Add To Cart" href='<c:url value="/cart/add-to-cart?id=${product.id}"></c:url>'><i class="ion-android-cart"></i></a>
		                                                <a title="Wishlist" href='<c:url value="/account/wishlist/add-to-wishlist?id=${product.id}"></c:url>'><i class="ion-ios-heart-outline"></i></a>
		                                            </div>
	                                                <h4>
	                                                    <a href='<c:url value="/${product.url}"></c:url>' class="title-product">${product.name}</a>
	                                                </h4>
	                                                <div class="product-price-wrapper">
	                                                    <span><fmt:formatNumber value="${product.price}" type="currency" /> </span>
	                                                    <!-- <span class="product-price-old">$120.00 </span> -->
	                                                </div>
	                                            </div>
	                                        </div>
                                  	  </div>                                   
                                   </c:forEach>                                 
                                </div>
                            </div>                                                       
                            <div class="pagination-total-pages">
                                <div class="pagination-style">
                                    <ul>
                                        <li>
                                        	<c:choose>
                                        		<c:when test="${pageInfo.pageIndex == 1}">
                                        			<a class="prev-next prev" href="javascript:void(0)"><i class="ion-ios-arrow-left"></i> Prev</a>
                                        		</c:when>
                                        		<c:otherwise>
                                        			<a class="prev-next prev" onclick="gotoPage(${pageInfo.pageIndex - 1})" href="javascript:void(0)"><i class="ion-ios-arrow-left"></i> Prev</a>
                                        		</c:otherwise>
                                        	</c:choose>
                                        </li>     
                                        <c:forEach begin="1" end="${pageInfo.totalPage}" varStatus="i">
                                        	<li>
	                                        	<c:choose>
	                                        		<c:when test="${pageInfo.pageIndex == i.index}">
	                                        		 	<a class="active" href="javascript:void(0)">${i.index}</a>
	                                        		</c:when>
	                                        		<c:otherwise>
	                                        			<a  onclick="gotoPage(${i.index})">${i.index}</a>
	                                        		</c:otherwise>                                     		
	                                        	</c:choose>
                                        	</li>
                                        </c:forEach>	
                                       
                                        <c:if test="${pageInfo.totalPage - pageInfo.pageIndex  > 3}">
                                         	<li><a href="#">...</a></li>
                                        	<li><a href="#">${pageInfo.totalPage}</a></li>
                                        </c:if>
                                        <li>
                                        	<c:choose>
                                        		<c:when test="${pageInfo.pageIndex == pageInfo.totalPage  }">
                                        			<a class="prev-next next" href="javascript:void(0)">Next<i class="ion-ios-arrow-right"></i> </a>
                                        		</c:when>
                                        		<c:otherwise>
                                        			<a class="prev-next next" onclick="gotoPage(${pageInfo.pageIndex + 1})" href="javascript:void(0)">Next<i class="ion-ios-arrow-right"></i> </a>
                                        		</c:otherwise>
                                        	</c:choose>
                                        </li>
                                    </ul>
                                </div>
                               <!--  <div class="total-pages">
                                    <p>Showing 1 - 20 of 30 results  </p>
                                </div> -->
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-3">
                        <div class="shop-sidebar-wrapper gray-bg-7 shop-sidebar-mrg">
                            <div class="shop-widget">
                                <h4 class="shop-sidebar-title">Shop By Categories</h4>
                                <div class="shop-catigory">
                                    <ul id="faq">
                                    <c:forEach items="${menuInfo}" var="menu" varStatus="i">
                                        <li> <a data-toggle="collapse" data-parent="#faq" href="#shop-catigory-${i.index + 1}">${menu.name }<i class="ion-ios-arrow-down"></i></a>
                                            <ul id="shop-catigory-${i.index + 1}" class="panel-collapse collapse show">
                                                <c:forEach items="${menu.childCategory}" var="item">
                                                	<li id="${item.idCategory}"><a   href='<c:url value="/the-loai/${item.url}"></c:url>'>${item.name} </a></li>
                                                </c:forEach>                                                                                                
                                            </ul>
                                        </li>
                                    </c:forEach>    
                                    </ul>
                                </div>
                            </div>
                            
                            <div class="shop-price-filter mt-40 shop-sidebar-border pt-35">
                                <h4 class="shop-sidebar-title">Price Filter</h4>
                                <div class="price_filter mt-25">
                                    <span>Range:  $100.00 - 1.300.00 </span>
                                    <div id="slider-range"></div>
                                    <div class="price_slider_amount">
                                        <div class="label-input">
                                            <input type="text" id="amount" name="price"  placeholder="Add Your Price" />
                                        </div>
                                        <button type="button">Filter</button> 
                                    </div>
                                </div>
                            </div>
                            <div class="shop-widget mt-40 shop-sidebar-border pt-35">
                                <h4 class="shop-sidebar-title">By Brand</h4>
                                <div class="sidebar-list-style mt-20">
                                    <ul>
                                        <li><input type="checkbox"><a href="#">Poure </a></li>
                                        <li><input type="checkbox"><a href="#">Eveman </a></li>
                                        <li><input type="checkbox"><a href="#">Iccaso </a></li>
                                        <li><input type="checkbox"><a href="#">Annopil </a></li>
                                        <li><input type="checkbox"><a href="#">Origina </a></li>
                                        <li><input type="checkbox"><a href="#">Perini  </a></li>
                                        <li><input type="checkbox"><a href="#">Dolloz </a></li>
                                        <li><input type="checkbox"><a href="#">Spectry </a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <script type="text/javascript">
        var sort = document.getElementById('sort');
       	$('#s').val('${param.s}');
        if('${param.sort}'){
        	sort.value = '${param.sort}';
        }
        sort.addEventListener('change',function(){
        	$("#searchForm").attr('action','<c:url value="/tim-kiem/"></c:url>');
        	$("#searchForm").submit();       	
        });
        function gotoPage(page){
        	$("#searchForm").attr('action','<c:url value="/tim-kiem/"/>');
        	$("#searchForm").append('<input type="hidden" name="trang" value='+page+'>')
        	$("#searchForm").submit();  
        }
		</script>
        