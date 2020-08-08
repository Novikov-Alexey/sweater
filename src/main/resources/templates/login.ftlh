<#import "parts/common.ftlh" as c>
<#import "parts/login.ftlh" as l>

<@c.page>
    ${message?ifExists}
    <#if Session?? && Session.SPRING_SECURITY_LAST_EXCEPTION?? && RequestParameters.error??>
        <div class="alert alert-danger" role="alert">
            ${Session.SPRING_SECURITY_LAST_EXCEPTION.message}
        </div>
    </#if>
<@l.login "/login" "Sign in" false/>
</@c.page>