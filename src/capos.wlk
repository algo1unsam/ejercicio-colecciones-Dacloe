
object rolando {
	const armas = #{}
 	const armasVistas = []
 	var property capacidad = 2
 	
	method agarra(_arma){
	if (armas.size()<capacidad){ 
	armas.add(_arma)}
	
	armasVistas.add(_arma)	
		}

	method llegaACastillo() {
	castilloDePiedra.dejarArmas(armas) 
	armas.clear()
		}

	method queArmas(){
	return armas
}

	method posesiones(){
	return self.queArmas() + castilloDePiedra.queArmasCastillo()
	}

}	
///////

object espada{}

object libro{}

object collar{}

object armadura{}

//////

object castilloDePiedra{
 	const armasRolando= #{}
 
 	method dejarArmas(_armas){
 	armasRolando.addAll(_armas)
 	}
 
 	method queArmasCastillo(){
 	return armasRolando }
 
	}
