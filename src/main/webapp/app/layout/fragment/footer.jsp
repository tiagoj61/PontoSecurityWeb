            <%@taglib prefix="s" uri="/struts-tags"%>

            </section>
            <footer class="site-footer">
                <div class="text-center">
                    <s:date name="currentDate" format="Y" /> - TORKE &copy; Audax
                    <a href="#" class="go-top">
                        <i class="fas fa-angle-up"></i>
                    </a>
                </div>
            </footer>
        </section>
        <script src="https://unpkg.com/@popperjs/core@2.8.4/dist/umd/popper.min.js"></script>
        <script type="text/javascript" src="../layout/js/jquery.js"></script>
        <script type="text/javascript" src="../layout/js/bootstrap.min.js"></script>
        <script class="include" type="text/javascript" src="../layout/js/jquery.dcjqaccordion.2.7.js"></script>
        <script type="text/javascript" src="../layout/js/jquery.scrollTo.min.js"></script>
        <script type="text/javascript" src="../layout/js/jquery.nicescroll.js"></script>
        <script type="text/javascript" src="../layout/js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../layout/js/localization/messages_pt_BR.js"></script>
        <script type="text/javascript" src="../layout/js/respond.min.js" ></script>
        <script type="text/javascript" src="../layout/assets/toastr-master/toastr.js"></script>
        <script type="text/javascript" src="../layout/assets/gritter/js/jquery.gritter.js"></script>
        <!--right slidebar-->
        <script type="text/javascript" src="../layout/js/slidebars.min.js"></script>
        <!--common script for all pages-->
        <script type="text/javascript" src="../layout/js/common-scripts.js"></script>
        <script type="text/javascript" src="../layout/js/windows.js"></script>
        <script type="text/javascript" src="../layout/assets/bootstrap-fileupload/bootstrap-fileupload.js"></script>
        <script type="text/javascript" src="../layout/assets/bootstrap-inputmask/bootstrap-inputmask.min.js"></script>
        <script type="text/javascript" src="../layout/assets/fancybox/dist/jquery.fancybox.min.js"></script>

        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/moment.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.14.1/locale/pt-br.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <script src="https://cdn.jsdelivr.net/gh/gitbrent/bootstrap4-toggle@3.6.1/js/bootstrap4-toggle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>
        
        
        <script type="text/javascript" src="../layout/js/jquery.validate.min.js"></script>
        <script type="text/javascript" src="../layout/js/localization/messages_pt_BR.js"></script>
        <script type="text/javascript" src="../layout/js/util.min.js"></script>
        <script type="text/javascript" src="../layout/js/commons-utils.min.js"></script>
        <script type="text/javascript">
            $(".fancybox").fancybox({openEffect: "elastic", closeEffect: "elastic", helpers: {title: {type: "inside"}}}), $(".fancybox-iframe").fancybox({openEffect: "elastic", closeEffect: "elastic", type: "iframe", iframe: {preload: !1}});
        
            window.onbeforeprint = function (event) {
                $(window).scrollTop(0);
                $("header.header").css("position", "absolute");
                $("body").addClass("is-sidebar-nav-open");
            };
            window.onafterprint = function (event) {
                $("header.header").css("position", "fixed");
                $("body").removeClass("is-sidebar-nav-open");
            };
        </script>
        ${param.scripts}
    </body>
</html>
