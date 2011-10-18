// jquery.pjax.js
// copyright chris wanstrath
// https://github.com/defunkt/jquery-pjax
(function(a){a.fn.pjax=function(b,c){c?c.container=b:c=a.isPlainObject(b)?b:{container:b};if(c.container&&typeof c.container!="string")throw"pjax container must be a string selector!";return this.live("click",function(b){if(b.which>1||b.metaKey)return!0;var d={url:this.href,container:a(this).attr("data-pjax"),clickedElement:a(this),fragment:null};a.pjax(a.extend({},d,c)),b.preventDefault()})};var b=a.pjax=function(c){var d=a(c.container),e=c.success||a.noop;delete c.success;if(typeof c.container!="string")throw"pjax container must be a string selector!";c=a.extend(!0,{},b.defaults,c),a.isFunction(c.url)&&(c.url=c.url()),c.context=d,c.success=function(d){if(c.fragment){var f=a(d).find(c.fragment);if(f.length)d=f.children();else return window.location=c.url}else if(!a.trim(d)||/<html/i.test(d))return window.location=c.url;this.html(d);var g=document.title,h=a.trim(this.find("title").remove().text());h&&(document.title=h),!h&&c.fragment&&(h=f.attr("title")||f.data("title"));var i={pjax:c.container,fragment:c.fragment,timeout:c.timeout},j=a.param(c.data);j!="_pjax=true"&&(i.url=c.url+(/\?/.test(c.url)?"&":"?")+j),c.replace?window.history.replaceState(i,document.title,c.url):c.push&&(b.active||(window.history.replaceState(a.extend({},i,{url:null}),g),b.active=!0),window.history.pushState(i,document.title,c.url)),(c.replace||c.push)&&window._gaq&&_gaq.push(["_trackPageview"]);var k=window.location.hash.toString();k!==""&&(window.location.href=k),e.apply(this,arguments)};var f=b.xhr;return f&&f.readyState<4&&(f.onreadystatechange=a.noop,f.abort()),b.options=c,b.xhr=a.ajax(c),a(document).trigger("pjax",[b.xhr,c]),b.xhr};b.defaults={timeout:650,push:!0,replace:!1,data:{_pjax:!0},type:"GET",dataType:"html",beforeSend:function(a){this.trigger("pjax:start",[a,b.options]),this.trigger("start.pjax",[a,b.options]),a.setRequestHeader("X-PJAX","true")},error:function(a,c,d){c!=="abort"&&(window.location=b.options.url)},complete:function(a){this.trigger("pjax:end",[a,b.options]),this.trigger("end.pjax",[a,b.options])}};var c="state"in window.history,d=location.href;a(window).bind("popstate",function(b){var e=!c&&location.href==d;c=!0;if(e)return;var f=b.state;if(f&&f.pjax){var g=f.pjax;a(g+"").length?a.pjax({url:f.url||location.href,fragment:f.fragment,container:g,push:!1,timeout:f.timeout}):window.location=location.href}}),a.inArray("state",a.event.props)<0&&a.event.props.push("state"),a.support.pjax=window.history&&window.history.pushState&&window.history.replaceState&&!navigator.userAgent.match(/(iPod|iPhone|iPad|WebApps\/.+CFNetwork)/),a.support.pjax||(a.pjax=function(b){window.location=a.isFunction(b.url)?b.url():b.url},a.fn.pjax=function(){return this})})(jQuery)