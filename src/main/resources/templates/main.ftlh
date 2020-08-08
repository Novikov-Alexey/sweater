<#import "parts/common.ftlh" as c>

<@c.page>

    <div class="form-group row">
        <div class="form-group col-md-6">
            <form method="get" action="/main" class="form-inline">
                <input type="text" name="filter" value="${filter!""}" class="form-control" placeholder="Search by tag">
                <button type="submit" class="btn btn-primary ml-2">Search</button>
            </form>
        </div>
    </div>

    <a class="btn btn-primary" data-toggle="collapse" href="#collapseExample" role="button" aria-expanded="false" aria-controls="collapseExample">
        Add new message
    </a>

    <div class="collapse <#if message??>show</#if>" id="collapseExample">
        <div class="form-group mt-3">
            <form method="post" enctype="multipart/form-data" action="/main">
                <div class="form-group">
                    <input type="text" name="text" class="form-control ${(textError??)?string("is-invalid","")}"
                           value="<#if message??>${message.text}</#if>"
                           placeholder="Введите сообщение"/>
                    <#if textError??>
                        <div class="invalid-feedback">
                            ${textError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <input type="text" name="tag" class="form-control ${(tagError??)?string("is-invalid","")}"
                           value="<#if message??>${message.tag}</#if>"
                           placeholder="Тэг"/>
                    <#if tagError??>
                        <div class="invalid-feedback">
                            ${tagError}
                        </div>
                    </#if>
                </div>
                <div class="form-group">
                    <div class="custom-file">
                        <input type="file" class="custom-file-input" id="customFile" name="file" placeholder="Файл"/>
                        <label class="custom-file-label" for="customFile">Choose file</label>
                    </div>
                </div>
                <input type="hidden" name="_csrf" value="${_csrf.token}">
                <div class="form-group">
                    <button type="submit" class="btn btn-primary">Добавить</button>
                </div>
            </form>
        </div>
    </div>

    <div class="card-columns">
    <#list messages as message>
        <div class="card my-3">

            <#if message.filename??>
                <img src="/img/${message.filename}" class="card-img-top">
            </#if>

            <div class="card-body m-2">
                <h5 class="card-title">${message.tag}</h5>
                <p class="card-text">${message.text}</p>
            </div>

            <div class="card-footer text-muted">
                ${message.authorName}
            </div>

        </div>
    <#else>
        No messages
    </#list>
    </div>
</@c.page>