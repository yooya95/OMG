<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    <!-- Layout wrapper -->
    <div class="layout-wrapper layout-content-navbar">
      <div class="layout-container">
		<!-- Menu -->
        <aside id="layout-menu" class="layout-menu menu-vertical menu bg-menu-theme">
          <div class="app-brand demo">
            <a href="/" class="app-brand-link">
              <span class="app-brand-logo demo">
                <img src="../assets/img/logo2.png" alt="logo">
              </span>
            </a>

            <a href="javascript:void(0);" class="layout-menu-toggle menu-link text-large ms-auto d-block d-xl-none">
              <i class="bx bx-chevron-left bx-sm align-middle"></i>
            </a>
          </div>

          <div class="menu-inner-shadow"></div>

          <ul class="menu-inner py-1">
            <!-- Dashboard -->
            <li class="menu-item">
              <a href="/" class="menu-link">
                <i class="menu-icon tf-icons bx bx-home-circle"></i>
                <div data-i18n="Analytics">Home</div>
              </a>
            </li>
			
			<c:if test="${sessionScope.mem_dept_md == 101 || sessionScope.mem_dept_md == 999}">
				<li class="menu-header small text-uppercase">
	              <span class="menu-header-text">사원 관리</span>
	            </li>
	            <li class="menu-item">
	              <a href="/memberL" class="menu-link">
	                <i class="menu-icon tf-icons bx bx-dock-top"></i>
	                <div data-i18n="Account Settings">사원 조회</div>
	              </a>
	            </li>
	            <li class="menu-item">
	              <a href="/memberR" class="menu-link">
	              	<i class="menu-icon tf-icons bx bx-detail"></i>
	                <div data-i18n="Form Elements">사원 등록</div>
	              </a>
	            </li>
			</c:if>
			
            <li class="menu-header small text-uppercase">
              <span class="menu-header-text">제품 관리</span>
            </li>
            <li class="menu-item">
              <a href="/item/list" class="menu-link">
                <i class="menu-icon tf-icons bx bx-dock-top"></i>
                <div data-i18n="Account Settings">제품 조회</div>
              </a>
            </li>
            <c:if test="${sessionScope.mem_dept_md == 104 || sessionScope.mem_dept_md == 105 || sessionScope.mem_dept_md == 999}">
            <li class="menu-item">
              <a href="/item/create" class="menu-link">
              	<i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Elements">제품 등록</div>
              </a>
            </li>
            </c:if>
            <!-- WareHouse -->
            <!--Customer  -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">거래처 관리</span></li>
            <!-- User interface -->
            <li class="menu-item">
              <a href="/customerList" class="menu-link ">
                <i class="menu-icon tf-icons bx bx-box"></i>
                <div data-i18n="User interface">거래처조회</div>
              </a>
            </li>
            
            <!-- Extended components -->
            <li class="menu-item">
              <a href="/customerSales" class="menu-link ">
                <i class="menu-icon tf-icons bx bx-box"></i>
                <div data-i18n="Extended UI">월별실적조회</div>
              </a>
            </li>

            <!-- Sales -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">주문관리</span></li>
            <!-- Forms -->
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Elements">발주관리</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="/purWriteForm" class="menu-link">
                    <div data-i18n="Basic Inputs">발주서 작성</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="/purList" class="menu-link">
                    <div data-i18n="Input groups">발주 리스트</div>
                  </a>
                </li>
              </ul>
            </li>
            <li class="menu-item">
              <a href="javascript:void(0);" class="menu-link menu-toggle">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Layouts">수주관리</div>
              </a>
              <ul class="menu-sub">
                <li class="menu-item">
                  <a href="/sales/salesInsertForm" class="menu-link">
                    <div data-i18n="Vertical Form">수주서 작성</div>
                  </a>
                </li>
                <li class="menu-item">
                  <a href="/sales/salesInquiry" class="menu-link">
                    <div data-i18n="Horizontal Form">수주 리스트</div>
                  </a>
                </li>
              </ul>
            </li>
            <!-- Purchase -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">재고 관리</span></li>
            <!-- Forms -->
            <li class="menu-item">
               <a href="/invRegister" class="menu-link">
                <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Elements">월재고관리</div>
              </a>
            </li>

            <li class="menu-item">
              <a href="/inboundRegister" class="menu-link">
                 <i class="menu-icon tf-icons bx bx-detail"></i>
                <div data-i18n="Form Elements">입출고관리</div>
              </a>
            </li>

       <!-- Tables -->
            <li class="menu-item">
              <a href="/inventoryList" class="menu-link">
                <i class="menu-icon tf-icons bx bx-table"></i>
                <div data-i18n="Tables">재고조회</div>
              </a>
            </li>
            
            <!-- Misc -->
            <li class="menu-header small text-uppercase"><span class="menu-header-text">고객 지원</span></li>
				<li class="menu-item">
					<a href="/notice/list" class="menu-link">
						<i class="menu-icon tf-icons bx bx-support"></i>
						공지사항
					</a>
				</li>
<!-- 				<li class="menu-item"> -->
<!-- 					<a href="/qna" class="menu-link"> -->
<!-- 						<i class="menu-icon tf-icons bx bx-support"></i> -->
<!-- 						문의 -->
<!-- 					</a> -->
<!-- 				</li> -->
				<li class="menu-item">
              <a
                href="https://github.com/syr96/OMG"
                target="_blank"
                class="menu-link"
              >
                <i class="menu-icon tf-icons bx bxl-github"></i>
                <div data-i18n="Support">Github</div>
              </a>
            </li>
            <li class="menu-item">
              <a
                href="https://www.notion.so/OMG-ver-1-cde90b0237404add997afd8ab99bb766"
                target="_blank"
                class="menu-link"
              >
                <i class="menu-icon tf-icons bx bx-file"></i>
                <div data-i18n="Documentation">Notion</div>
              </a>
            </li>
          </ul>
        </aside>
        <!-- / Menu -->
        
        <!-- Layout container -->
        <div class="layout-page">
          <!-- Navbar -->

			<nav
            class="layout-navbar navbar navbar-expand-xl align-items-center bg-light"
            id="layout-navbar"
            >
            <div class="layout-menu-toggle navbar-nav align-items-xl-center me-3 me-xl-0 d-xl-none">
              <a class="nav-item nav-link mx-3" href="javascript:void(0)">
                <i class="bx bx-menu bx-sm"></i>
              </a>
            </div>

            <div class="navbar-nav-right d-flex align-items-center mx-3" id="navbar-collapse">

              <ul class="navbar-nav flex-row align-items-center ms-auto">

                <!-- User -->
                <li class="nav-item navbar-dropdown dropdown-user dropdown">
                  <a class="nav-link dropdown-toggle hide-arrow" href="javascript:void(0);" data-bs-toggle="dropdown">
                    <div class="avatar avatar-online">
                      <img src="${pageContext.request.contextPath}/upload/sh/${sessionScope.mem_img}" alt class="w-px-40 h-auto rounded-circle" />
                    </div>
                  </a>
                  <ul class="dropdown-menu dropdown-menu-end">
                    <li>
                      <a class="dropdown-item" href="#">
                        <div class="d-flex">
                          <div class="flex-shrink-0 me-3">
                            <div class="avatar avatar-online">
                              <img src="${pageContext.request.contextPath}/upload/sh/${sessionScope.mem_img}" alt class="w-px-40 h-auto rounded-circle" />
                            </div>
                          </div>
                          <div class="flex-grow-1">
                            <span class="fw-semibold d-block">${sessionScope.mem_name }</span>
                            <small class="text-muted">
								<c:choose>
    <c:when test="${sessionScope.mem_dept_md eq 100}">
        회계팀
    </c:when>
    <c:when test="${sessionScope.mem_dept_md eq 101}">
        인사팀
    </c:when>
    <c:when test="${sessionScope.mem_dept_md eq 102}">
        영업1팀
    </c:when>
    <c:when test="${sessionScope.mem_dept_md eq 103}">
        영업2팀
    </c:when>
    <c:when test="${sessionScope.mem_dept_md eq 104}">
        물류1팀
    </c:when>
    <c:when test="${sessionScope.mem_dept_md eq 105}">
        물류2팀
    </c:when>
    <c:when test="${sessionScope.mem_dept_md eq 106}">
        CS1팀
    </c:when>
    <c:when test="${sessionScope.mem_dept_md eq 107}">
        CS2팀
    </c:when>
    <c:when test="${sessionScope.mem_dept_md eq 999}">
        관리자
    </c:when>
    <c:otherwise>
        기타 부서
    </c:otherwise>
</c:choose>                          
                            </small>
                          </div>
                        </div>
                      </a>
                    </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <a class="dropdown-item" href="memberD?mem_id=${sessionScope.mem_id }">
                        <i class="bx bx-user me-2"></i>
                        <span class="align-middle">My Profile</span>
                      </a>
                    </li>
                    <li>
                      <div class="dropdown-divider"></div>
                    </li>
                    <li>
                      <a class="dropdown-item" href="/logOut">
                        <i class="bx bx-power-off me-2"></i>
                        <span class="align-middle">Log Out</span>
                      </a>
                    </li>
                  </ul>
                </li>
                <!--/ User -->
              </ul>
            </div>
          </nav>
			<!-- / Navbar -->

          <!-- Content wrapper -->
          <div class="content-wrapper">
          
          	<div class="container-xxl flex-grow-1 container-p-y">

