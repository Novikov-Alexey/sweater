<#import "parts/common.ftlh" as c>
<#include "parts/security.ftlh">
<@c.page>
    <h5>Hello, <#if name!="unknown">${name}<#else>guest</#if>
    </h5>
</@c.page>
