// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {
	
    $("#users_id").tokenInput('/usuarios.json',{
    	crossDomain:false,
    	propertyToSearch: "email",
    	theme:"facebook",
	 	hintText: "digite o email que deseja buscar",
        noResultsText: "Nenhum usuário encontrado",
        searchingText: "Procurando..."
    });

    $("#projetos_id").tokenInput('/projetos/lista.json',{
    	crossDomain:false,
    	propertyToSearch: "nome",
    	theme:"facebook",
	 	hintText: "digite o nome do projeto que deseja buscar",
        noResultsText: "Nenhum projeto encontrado",
        searchingText: "Procurando..."
    });
    
    $('#close').click(function(){
    	$('#notice').slideUp(700);
    });
});

montaArray = function(array, inicio, razao, duracao){
		pontos = new Array;
		pontos[0] = ['Dia', 'Ideal', 'Real'];
		n = array.length;
		total = inicio;
		for(i=0;i<n;i++){
			if(i==0){
				pontos[i+1] = [i, total, total];
			}
			else{
				pontos[i+1] = [i, total, array[i]];	
			}
			total = total-razao;
		};
		
		atual = pontos.length - 1;
		for(i=atual;i<=duracao;i++){
			pontos[i+1] = [i,total,null];
			total = total-razao;			
		}
		
		return pontos;
	};