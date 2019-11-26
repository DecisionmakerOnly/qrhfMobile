/**
 *
 */
	(function($) {
    $.fn.regionselect2 = function(argoptions) {
    	var argdefault={
 			   pid:"1",
 			   proname:'province',
 			   cityname:'city',
 			   areaname:'area',
 			   proid:'province',
 			   cityid:'city',
 			   areaid:'area',
 			   proval:'',
 			   cityval:'',
 			   areaval:'',
 			   level:3
    	};
    	var ajaxmethod=function(url,pid,selectionclass){
    		param={pid:pid};
			$.get(url,param,function(data){
//				var jsonData=JSON.parse(data);
				$.each(data,function(i,value){
					if($('#'+selectionclass).val()==value['name']){
						$("."+selectionclass).append("<option selected='selected' idq='"+value['id']+"' value='"+value['name']+"'>"+value['name']+"</option>");
						$("."+selectionclass).trigger('change');
					}else{
						$("."+selectionclass).append("<option idq='"+value['id']+"' value='"+value['name']+"'>"+value['name']+"</option>");	
					}
				});
			});
    	};
        var options = $.fn.extend({},argdefault,argoptions);
        //options.url=options.basepath+options.actionurl;
        return this.each(function() {
			var oo = $(this);
			//var a=oo.offset();
			var oowidth=oo.css("width");
//			console.info(pid);
			oo.after("<select name='"+options.proid+"' id='"+options.proid+"' class='form-control "+options.proid+"' name='"+options.proname+"' style='display:inline-block;width:"+oowidth+"'><option value='' idq=''>--省--</option></select>");
			oo.css("display","none");
			var cityobj=$("#"+options.cityid);
			var citywidth=cityobj.css("width");
			cityobj.after("<select class='form-control "+options.cityid+"' name='"+options.cityname+"' style='display:inline-block;width:"+citywidth+"'></select>");
			cityobj.css("display","none");
			
			var areaobj=$("#"+options.areaid);
			var areawidth=areaobj.css("width");
			areaobj.after("<select class='form-control "+options.areaid+"' name='"+options.areaname+"' style='display:inline-block;width:"+areawidth+"'></select>");
			areaobj.css("display","none");
			
			ajaxmethod(options['url'],options['pid'],options['proid']);
			$("."+options.proid).bind("change",function(){
				var provselected=$("."+options.proid+" option:selected").attr("idq");
				$("#province").val(provselected);
//				console.info(provselected);
				if($("."+options.cityid).length>0){
					$("."+options.cityid).empty();
					$("."+options.cityid).append("<option value=''>-- --</option>");
					ajaxmethod(options['url'],provselected,options['cityid']);
				}
				if($("."+options.areaid).length>0){
					$("."+options.areaid).empty();
				}
			});
			$("."+options.cityid).bind("change",function(){
				var cityselected=$("."+options.cityid+" option:selected").attr("idq");
				$("#city").val(cityselected);
//				console.info(cityselected);
				if($("."+options.areaid).length>0){
					$("."+options.areaid).empty();
					$("."+options.areaid).append("<option value=''>-- --</option>");
					ajaxmethod(options['url'],cityselected,options['areaid']);
				}
			});
			$("."+options.areaid).bind("change",function(){
				var areaselected=$("."+options.areaid+" option:selected").attr("idq");
				$("#area").val(areaselected);
			});
        });
       
	};
})(jQuery);