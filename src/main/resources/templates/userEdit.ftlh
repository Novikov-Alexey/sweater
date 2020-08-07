<#import "parts/common.ftlh" as c>

<@c.page>
    User editor
    <#if user??>
        <form action="/user" method="post">
            <input type="text" value="${user.username}" name="username">
            <#list roles as role>
                <div>
                    <label><input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>${role}</label>
                </div>
            </#list>
            <input type="hidden" value="${user.id}" name="userID">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit">Save</button>
        </form>
    <#else>
        <div>Can't find User</div>
    </#if>
</@c.page>