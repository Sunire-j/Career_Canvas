<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="../header_footer/header.jspf" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Title</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="${pageContext.servletContext.contextPath}/css/users/signup.css">
    <script>
        $(function(){
            $('input[name="userPwd"]').on('input blur', function () {
                if (this.checkValidity()) {
                    $(this).removeClass('is-invalid').addClass('is-valid');
                } else {
                    $(this).removeClass('is-valid').addClass('is-invalid');
                    $(this).siblings('.invalid-feedback').hide();
                    if (this.validity.valueMissing) {
                        $(this).siblings('.invalid-feedback:not([data-feedback])').show();
                    } else if (this.validity.patternMismatch) {
                        $(this).siblings('[data-feedback="patternMismatch"]').show();
                    }
                }
            });

            $('#userPwd, #userPwdCheck').on('input blur', function () {
                var password = $('#userPwd').val();
                var confirmPassword = $('#userPwdCheck').val();

                if (confirmPassword) {
                    if (password !== confirmPassword) {
                        $('#userPwdCheck').removeClass('is-valid').addClass('is-invalid');
                        $('#userPwdCheck').siblings('.invalid-feedback:not([data-feedback])').hide();
                        $('#userPwdCheck').siblings('[data-feedback="passwordMismatch"]').show();
                    } else {
                        $('#userPwdCheck').removeClass('is-invalid').addClass('is-valid');
                        $('#userPwdCheck').siblings('.invalid-feedback').hide();
                    }
                } else {
                    $('#userPwdCheck').removeClass('is-valid').addClass('is-invalid');
                    $('#userPwdCheck').siblings('.invalid-feedback:not([data-feedback])').show();
                }
            });

            $('.needs-validation input').on('change', function() {
                // 모든 필수 입력 항목이 is-valid 클래스를 가지고 있는지 확인
                let isValid =
                    $("input[name='userPwd']").hasClass('is-valid') &&
                    $("input[name='userPwdCheck']").hasClass('is-valid');


                // 모든 조건이 만족하면 submit 버튼 활성화, 아니면 비활성화
                if(isValid) {
                    $(".pwchangebtn").prop('disabled', false);
                } else {
                    $(".pwchangebtn").prop('disabled', true);
                }
            });
        });
    </script>
</head>
<body>
<div class="container" style="padding: 0px; margin-top: 150px">
    <div class="container-head"></div>
    <div style="padding: 0px 50px 30px 50px">
        <h3 class="signupTitle" style="text-align: center; margin-top: 10px">비밀번호 변경</h3>
        <hr class="hr-styleset">
        <div>
            <%--가입 유형 선택--%>
            <div style="width: 60%; margin: 10px auto 0;">
                <form action="${pageContext.servletContext.contextPath}/startchangepwd" method="post"
                      class="signupFrm needs-validation" novalidate>
                    <ul style="padding: 0; margin-top: 30px">
                        <li>
                            <div>
                                <input type="password" id="userPwd" name="userPwd" class="form-control"
                                       placeholder="비밀번호"
                                       pattern="^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[\W]).{8,20}$" required/>
                                <div class="invalid-feedback">비밀번호를 입력해주세요.</div>
                                <div class="invalid-feedback" data-feedback="patternMismatch">8~20자, 영문, 숫자, 특문을 모두
                                    이용해주세요.
                                </div>
                            </div>
                        </li>
                        <li>
                            <div>
                                <input type="password" id="userPwdCheck" name="userPwdCheck" class="form-control"
                                       placeholder="비밀번호 확인"
                                       required/>
                                <div class="invalid-feedback" data-feedback="passwordMismatch">비밀번호를 확인해주세요.</div>
                            </div>
                        </li>
                    </ul>
                        <input type="submit" style="display: flex; margin: 0; margin-top: 10px"  class="btn btn-primary pwchangebtn" value="비밀번호 변경" disabled/>
                </form>
            </div>
        </div>
    </div>
        <div class="container_bottom"></div>

</div>
</form>
</body>
</html>

<%@include file="../header_footer/footer.jspf" %>