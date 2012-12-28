// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require edicao
//= require_tree .

$(document).ready(function() {
	
    $("#users_id").tokenInput('/usuarios.json',{
    	crossDomain:false,
    	propertyToSearch: "email",
    	theme:"facebook",
	 	hintText: "digite o email que deseja buscar",
        noResultsText: "Nenhum usuário encontrado",
        searchingText: "Procurando...",
     	minChars: 4	
    });

    $("#projetos_id").tokenInput('/projetos/lista.json',{
    	crossDomain:false,
    	propertyToSearch: "nome",
    	theme:"facebook",
	 	hintText: "digite o nome do projeto que deseja buscar",
        noResultsText: "Nenhum projeto encontrado",
        searchingText: "Procurando...",
        minChars: 4
    });
    
    $('#close').click(function(){
    	$('#notice').slideUp(700);
    });
    
    $("#botaoEditar").click(function() {
		$("#containerEdicao").dialog("open");
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

deletarTarefas = function(projeto_id){
   $(".deleteTarefas").click(function(){
   		if(confirm("tem certeza? todas as tarefas dessa coluna serão excluídas")){
   				pai = $(this).parent().attr('id');
   				switch(pai){
   					case("head1"):
   						coluna = 1;
   						break;
   					case("head2"):
   						coluna = 2;
   						break;
   					case("head3"):
   						coluna = 3;
   						break;
   				}
				var url = "/projetos/"+projeto_id+"/destroy_tarefas";
				var data =  				
				$.ajax({
					type: 'POST',
					url: url,
					data: { coluna : coluna},
					//async: false para que o script espere o post ser concluído antes de mudar de página
					//(pois, do contrário, pode sair da página antes da requisição estar completa e não salvar)
					success: function(data){
						alert(data.responseText);
						reloadTable(projeto_id);
					},
					error: function(data, text){
						alert(data.responseText);
						reloadTable(projeto_id);
					}
				});


   		}
   });
}

reloadTable = function(projeto_id){
	$.ajax({
		type: 'GET',
		url: "/projetos/"+projeto_id+"/tarefas_colunas",
		//async: false para que o script espere o post ser concluído antes de mudar de página
		//(pois, do contrário, pode sair da página antes da requisição estar completa e não salvar)
		success: function(data){
			montaTabela(data)
		},
		error: function(){
			alert('erro');
		}
	});

}

montaTabela = function(dados){
	$('.colunas').empty();
	var coluna1 = JSON.parse(dados.coluna1);
	var coluna2 = JSON.parse(dados.coluna2);
	var coluna3 = JSON.parse(dados.coluna3);

	$.each([coluna1, coluna2, coluna3], function(i,pai){
		$.each(pai, function(i,item){
			switch(item.status){
				case(1):
					div = "coluna1"
					break;
				case(2):
					div = "coluna2"
					break;
				case(3):
					div = "coluna3"
					break;
			} 
			$('#'+div).append(
				'<div id='+item.id+' class="postit" draggable="true" ondragstart="dragIt(this, event)">'+
					'<p title='+item.descricao+'>'+item.descricao+'</p>'+
				'</div>'
			);

		});
	});

}

montaArray = function(array, inicio, razao, duracao){
		pontos = new Array;
		pontos[0] = ['Dia', 'Ideal', 'Real'];
		n = array.length;
		total = inicio;
		for(i=0;i<n;i++){
			if(i==0){
				pontos[i+1] = [i.toString(), total, total];
			}
			else{
				pontos[i+1] = [i.toString(), total, array[i]];	
			}
			total = total-razao;
		};
		
		atual = pontos.length - 1;
		for(i=atual;i<=duracao;i++){
			pontos[i+1] = [i.toString(),total,null];
			total = total-razao;			
		}
		
		return pontos;
	};

mudaCor = function(pai, id, afazer, andamento, prontas){
		$('#'+id).removeClass(afazer);
		$('#'+id).removeClass(andamento);
		$('#'+id).removeClass(prontas);
		switch (pai){
			case ("coluna1"):
				$('#'+id).addClass(afazer);
				break;
			case ("coluna2"):
				$('#'+id).addClass(andamento);
				break;
			case ("coluna3"):
				$('#'+id).addClass(prontas);
				break;
		}
}
