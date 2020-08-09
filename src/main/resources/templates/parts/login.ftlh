<#include "security.ftlh">
<#macro login path btnText isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> User Name: </label>
            <div class="col-sm-6">
                <input type="text" name="username" class="form-control ${(usernameError??)?string("is-invalid","")}"
                       value="<#if user??>${user.username}</#if>"
                       placeholder="User Name"/>
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Password: </label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control ${(passwordError??)?string("is-invalid","")}"
                       placeholder="Password"/>
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>

        <#if isRegisterForm>
            <div class="form-group row">
                <label class="col-sm-2 col-form-label"> Password Сonfirmation: </label>
                <div class="col-sm-6">
                    <input type="password" name="passwordСonfirmation"
                           class="form-control ${(passwordСonfirmationError??)?string("is-invalid","")}"
                           placeholder="Retype password"/>
                    <#if passwordСonfirmationError??>
                        <div class="invalid-feedback">
                            ${passwordСonfirmationError}
                        </div>
                    </#if>
                </div>
            </div>

            <div class="form-group row">
                <label class="col-sm-2 col-form-label"> Email: </label>
                <div class="col-sm-6">
                    <input type="email" name="email" class="form-control ${(emailError??)?string("is-invalid","")}"
                           value="<#if user??>${user.email}</#if>"
                           placeholder="email@domain.ru"/>
                    <#if emailError??>
                        <div class="invalid-feedback">
                            ${emailError}
                        </div>
                    </#if>
                </div>
            </div>
            <div class="col-sm-6">
                <div class="g-recaptcha" data-sitekey="6LeEhbwZAAAAABFewGZyzFrTOs3hOAS2TEJHlBOQ"></div>
                <#if captchaError??>
                    <div class="alert alert-danger" role="alert">
                        ${captchaError}
                    </div>
                </#if>
                <#-- На проде убрать, оставить только для админа (ошибки каптчи с https://developers.google.com/recaptcha/docs/verify )-->
                <#if captchaCodeError??>
                    <div class="alert alert-warning" role="alert">
                        ${captchaCodeError}
                    </div>
                </#if>
            </div>

        </#if>

        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <#if !isRegisterForm><a href="/registration">Add new user</a></#if>
        <button type="submit" class="btn btn-primary" type="submit">${btnText}</button>

    </form>
</#macro>

<#macro logout>
    <#if name!="unknown">
        <form action="/logout" method="post">
            <button class="btn btn-primary" type="submit">Sign Out</button>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
        </form>
    <#else>
        <form action="/main" method="get">
            <button class="btn btn-primary" type="submit">Login</button>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
        </form>
    </#if>

</#macro>