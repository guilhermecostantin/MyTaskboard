editar = function(){
	$(document).ready(function() {
		
	    $("input[name='projeto[estilo_postit_default]']").change(function() {
			verificaDefault();	    	
	    });
	    
	    	
	    $("#botaoEditar").click(function() {
			$("#containerEdicao").dialog("open");
			verificaDefault();
		});
		
	     $("#fecharLightbox").click(function() {
			$("#containerEdicao").dialog("close");
		});
		
	   $("#containerEdicao").dialog({
					autoOpen : false,
					width : 850,
					modal : true,
					show : 'fade',
					hide : 'fade',
					resizable: false
				}); 
	});
}

verificaDefault = function(){
	def = $("input[name='projeto[estilo_postit_default]']:checked").val();
	if(def=="true"){
		$('#contColunas').hide();
	}
	else{
		$('#contColunas').show();
	}
}
