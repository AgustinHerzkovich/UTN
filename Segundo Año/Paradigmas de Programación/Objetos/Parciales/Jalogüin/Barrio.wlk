class Barrio {
    const ninios = #{}

    method tresNiniosQueMasCaramelosTienen() = ninios.sortedBy{ninio1, ninio2 => ninio1.tieneMasCaramelosQue(ninio2)}.take(3)

    method elementosUtilizadosConMasDe10Caramelos() = ninios.filter{ninio => ninio.tieneMasCaramelos(10)}.flatMap{ninio => ninio.elementos()}.withoutDuplicates()
}