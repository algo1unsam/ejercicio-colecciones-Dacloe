
object rolando {
	const armas = #{}
 	const armasVistas = []
 	var property capacidad = 2
 	var property poderBase = 5
 	
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
	
	method sumatoriaDePoderesArtefactos(){
		return armas.sum({ _arma => _arma.poder(self)})
	}

	method poder(){
		return self.poderBase() + self.sumatoriaDePoderesArtefactos()
	}

	method batalla(){
		poderBase+=1
		armas.forEach({_arma => _arma.usar()})
	}
	
	method poderArtefactoMasPoderosoDelCastillo(){
		return castilloDePiedra.poderArtefactoMasPoderoso(duenio)
		
	}
	
	method puedeVencer(enemigo){
		return self.poder()> enemigo.poderDePelea()
	}
		
}	

///////

object espada{
	var nueva = true
	 
	method poder(duenio){
		return duenio.poderBase()/ if(nueva){1} else{2} //para usar if más prolijo
		}
	
	method usar(){
		nueva = false
		}

}

///////

object libro{
	const hechizos = []
	
	method poder(duenio){
		return hechizos.first().poder(duenio)
	}
	
	method usar(){
		hechizos.drop(1)
	} 
	
	method agregarHechizo(_hechizo){
		hechizos.add(_hechizo)
	}
	}

/////// hechizos

object bendicion {
	
	method poder(duenio){
		return 4
	}
}


object invisibilidad {
	
	method poder(duenio){
		return duenio.poderBase()
		}
}


object invocacion {
	method poder(duenio){
		return duenio.poderArtefactoMasPoderosoDelCastillo()
	}
}

///////

object collar{ //se tiene que acordar de cuantas batallas tuvo 
	var cantidadDeBatallas = 0
	const base = 3
	
	method usar(){
		cantidadDeBatallas +=1
	}
	
	method poder(duenio){
		return base + if (duenio.poderBase()>6){cantidadDeBatallas} else {0}
	}
}

///////

object armadura{
	method poder(duenio) = 6
	method usar(){} //no tiene efecto
}

//////

object castilloDePiedra{
 	const armasRolando= #{}
 
 	method dejarArmas(_armas){
 		armasRolando.addAll(_armas)
 	}
 
 	method queArmasCastillo(){
	 	return armasRolando }
 
 	method poderArtefactoMasPoderoso(duenio){
 		if (armasRolando.isEmpty()){
 			return 0
 		}
 		else {return self.poderMasPoderoso(duenio).poder(duenio)}
 	}

 	
 	method poderMasPoderoso(duenio){
 		return armasRolando.max({_arma => _arma.poder(duenio)})
	 	}
 
	}

	///////
	
	object archibaldo{
		method poderDePelea()= 16
		method morada()= palacio	
		
	}
	
	//////
	
	object caterina{
		method poderDePelea()=28
		method morada() = fortaleza
	}
	
	//////
	
	object astra{
		method poderDePelea()=14
		method morada()=torre
		
	}
	
	/////
	
	object palacio{}
	
	//////
	
	object fortaleza{}
	
	//////
	
	object torre{}
	
	//////
	
	object erethia{
		
		const enemigos = #{archibaldo,caterina,astra}
	
		method enemigosVencibles(capo){
			return enemigos.filter({enemigo => capo.puedeVencer(enemigo)})
		}
		
		method moradasConquistables(capo){
			return self.enemigosVencibles(capo).map({enemigo=>enemigo.morada()})
		}	
		
		method poderoso(capo){
			const elMasPoderoso = enemigos.max({enemigo => enemigo.poderDePelea()})
			return capo.puedeVencer(elMasPoderoso)
			
		}
	
	}