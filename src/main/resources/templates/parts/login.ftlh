<#include "security.ftlh">
<#macro login path btnText isRegisterForm>
    <form action="${path}" method="post">
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> User Name: </label>
            <div class="col-sm-6">
                <input type="text" name="username" class="form-control" placeholder="User Name"/>
            </div>
        </div>

        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Password: </label>
            <div class="col-sm-6">
                <input type="password" name="password" class="form-control" placeholder="Password"/>
            </div>
        </div>

        <#if isRegisterForm>
        <div class="form-group row">
            <label class="col-sm-2 col-form-label"> Email: </label>
            <div class="col-sm-6">
                <input type="email" name="email" class="form-control" placeholder="email@domain.ru"/>
            </div>
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