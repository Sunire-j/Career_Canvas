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
    <script src="https://kit.fontawesome.com/f5234bf2d4.js" crossorigin="anonymous"></script>

    <script>
        $(function () {
            $('input[name="userId"]').on('input blur', function () {
                var $this = $(this);
                if (this.checkValidity()) {
                    $(this).removeClass('is-invalid').addClass('is-valid');
                    $.ajax({
                        url: "${pageContext.servletContext.contextPath}/checkId",
                        type: 'post',
                        data: {
                            id: $(this).val()
                        },
                        success: function (result) {
                            console.log(result);
                            if (result == 0) {
                                console.log("here0");
                                $(this).removeClass('is-invalid').addClass('is-valid');
                                //사용가능한 아이디입니다 표기
                            } else {
                                console.log("here1");
                                $this.removeClass('is-valid').addClass('is-invalid');
                                $this.siblings('.invalid-feedback').hide();
                                $this.siblings('[data-feedback="duplicate"]').show();
                            }
                        },
                        error: function (error) {
                            console.log(error.responseText);
                        }
                    });
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

            $('input[name="userEmail"]').on('input blur', function () {
                var $this = $(this);
                var $feedbacks = $this.parent().siblings('.invalid-feedback');
                var $button = $this.siblings('input[type="button"]');

                if (this.checkValidity()) {
                    $this.removeClass('is-invalid').addClass('is-valid');
                    $feedbacks.hide();
                    $button.prop('disabled', true);
                    $.ajax({
                        url: "${pageContext.servletContext.contextPath}/checkemail",
                        type: 'post',
                        data: {
                            email: $this.val()
                        },
                        success: function (result) {
                            if (result == 0) {
                                $this.removeClass('is-invalid').addClass('is-valid');
                                $button.prop('disabled', false);
                            } else {
                                $this.removeClass('is-valid').addClass('is-invalid');
                                $feedbacks.filter('[data-feedback="duplicate"]').show();

                                //
                                $this.removeClass('is-valid').addClass('is-invalid');
                                $this.siblings('.invalid-feedback').hide();
                                $this.siblings('[data-feedback="duplicate"]').show();
                            }
                        }
                    });
                } else {
                    $this.removeClass('is-valid').addClass('is-invalid');
                    $feedbacks.hide();
                    $button.prop('disabled', true);
                    if (this.validity.valueMissing) {
                        $feedbacks.filter(':not([data-feedback])').show();
                    } else if (this.validity.patternMismatch) {
                        $feedbacks.filter('[data-feedback="patternMismatch"]').show();
                    }
                }
            });
            $("#authbtn").on('click', function () {
                $.ajax({
                    url: '${pageContext.servletContext.contextPath}/emailsend',
                    data: {
                        email: $("#useremail").val()
                    },
                    type: 'post',
                    success: function (result) {
                        if (result == 0) {
                            $("#useremail").prop('disabled', true);
                            $("#authbtn").val("발송됨");
                            $("#authbtn").prop('disabled', true);
                            $("#emailauth").prop('disabled', false);
                            $("#emailauthbtn").prop('disabled', false);
                            $("#emailauthbtn").val("확인");
                            //시간 지나게 해주기
                            //인증번호 입력칸, 확인버튼 disabled 풀
                        }
                    },
                    error: function (error) {
                        console.log(error);
                    }
                });
            });

            $("#emailauthbtn").on('click', function () {
                $.ajax({
                    url: '${pageContext.servletContext.contextPath}/email/verify',
                    data: {
                        emailauth: $("#emailauth").val()
                    },
                    type: 'post',
                    success: function (result) {
                        if (result == 0) {//맞음
                            $("#emailauth").prop('disabled', true);
                            $("#emailauthbtn").val("인증됨");
                            $("#emailauthbtn").prop('disabled', true);
                            $("#userEmailcopy").val($("#useremail").val());
                        } else if (result == 2) {//틀림
                            $("#emailauthbtn").val("값오류");
                            $("#emailauth").val("");
                        } else {//이메일부터 다시쳐야함
                            $("#emailauthbtn").val("만료됨");
                            $("#useremail").prop('disabled', false);
                            $("#authbtn").val("메일인증");
                            $("#authbtn").prop('disabled', false);
                            $("#emailauth").prop('disabled', true);
                            $("#emailauthbtn").prop('disabled', true);
                        }
                    },
                    error: function (error) {
                        console.log(error.responseText);
                    }
                });
            });

            $('input[name="usertel"]').on('input blur', function () {
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

            $('.signupFrm input').on('change', function () {
                // 모든 필수 입력 항목이 is-valid 클래스를 가지고 있는지 확인
                let isValid = $("input[name='userId']").hasClass('is-valid') &&
                    $("input[name='userPwd']").hasClass('is-valid') &&
                    $("input[name='userPwdCheck']").hasClass('is-valid') &&
                    $("input[name='usertel']").hasClass('is-valid');

                // 특정 입력 항목들이 disabled 상태인지 확인
                let isDisabled = $("#useremail").prop('disabled') &&
                    $("#authbtn").prop('disabled') &&
                    $("#emailauth").prop('disabled') &&
                    $("#emailauthbtn").prop('disabled');

                // 모든 조건이 만족하면 submit 버튼 활성화, 아니면 비활성화
                if (isValid && isDisabled) {
                    $(".signup").prop('disabled', false);
                } else {
                    $(".signup").prop('disabled', true);
                }
            });
        });
    </script>
</head>
<body>
<div class="container" style="margin-top: 100px; padding: 0px">
    <div class="container-head"></div>
    <div class="signupFrm_wrapper">
        <p class="signupTitle">기업 회원가입</p>
        <hr class="hr-styleset">
        <form action="${pageContext.servletContext.contextPath}/signup/biz/complete" method="post"
              class="signupFrm needs-validation" novalidate>
            <ul style="padding: 0">
                <li>
                    <div>
                        <input type="text" name="userId" class="form-control" placeholder="아이디"
                               pattern="^[a-zA-Z0-9_\-\.]{5,50}$" required/>
                        <div class="invalid-feedback">아이디를 입력해주세요.</div>
                        <div class="invalid-feedback" data-feedback="patternMismatch">5~50자리, 영문, 숫자, _, -,
                            .만 사용해주세요.
                        </div>
                        <div class="invalid-feedback" data-feedback="duplicate">중복된 아이디입니다.</div>
                    </div>
                </li>
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
                <li>
                    <div>
                        <input type="text" name="userNickName" class="form-control" placeholder="회사명" value="${username}" readonly/>
                    </div>
                </li>
                <li>
                    <div>
                        <div class="input-group">
                            <input type="hidden" id="userEmailcopy" name="userEmail"/>
                            <input type="text" class="form-control userEmail" name="userEmail" id="useremail"
                                   pattern="[a-z0-9]+@[a-z]+\.[a-z]{2,3}" required
                                   placeholder="이메일">
                            <input type="button" class="btn btn-success" id="authbtn" value="메일인증"/>
                        </div>
                        <div class="invalid-feedback">이메일을 입력해주세요.</div>
                        <div class="invalid-feedback" data-feedback="patternMismatch">이메일 형식에 맞지 않습니다.
                        </div>
                        <div class="invalid-feedback" data-feedback="duplicate">중복된 이메일입니다.</div>
                    </div>
                </li>
                <li>
                    <div>
                        <div class="input-group">
                            <input type="text" class="form-control userEmailcheck" id="emailauth" required
                                   placeholder="인증번호" disabled>
                            <input type="button" class="btn btn-success" id="emailauthbtn" value="확인" disabled/>
                        </div>
                        <div class="invalid-feedback">이메일인증을 완료해주세요.</div>
                    </div>
                </li>
                <li>
                    <input type="text" name="usertel" class="form-control"
                           pattern="01[016789]-([0-9]{3}|[0-9]{4})-[0-9]{4}" placeholder="전화번호( - 포함)" required/>
                    <div class="invalid-feedback">휴대전화번호를 입력해주세요.</div>
                    <div class="invalid-feedback" data-feedback="patternMismatch">전화번호 형식에 맞지 않습니다.
                    </div>
                </li>
                <li>
                    <input type="text" name="companyno" class="form-control" value="${companyno}" readonly/>
                </li>
                <li>
                    <input type="hidden" name="tempimg" value="${tempimg}"/>
                    <div class="signupBtn">
                        <input type="button" class="btn btn-secondary reset" onclick="location.reload()"
                               value="다시작성"/>
                        <input type="submit" class="btn btn-primary signup" value="회원가입" disabled/>
                    </div>
                </li>
            </ul>
        </form>
    </div>
    <div class="container_bottom"></div>
</div>

</body>
</html>

<%@include file="../header_footer/footer.jspf" %>