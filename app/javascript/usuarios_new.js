function checkTipoPersona(tipoPersona) {

    let selectTipoDocumento = document.getElementById('usuario_tipo_documento_id')
    let labelNombre = document.querySelector('#input_nombre > label')
    let labelDocumento = document.querySelector('#input_documento > label')

    if (tipoPersona == 2) {
        selectTipoDocumento.value = 3
        labelNombre.textContent = 'Nombre de la empresa'
        labelDocumento.textContent = 'Número de documento de la empresa'

    } else {
        selectTipoDocumento.value = 1
        labelNombre.textContent = 'Nombre completo'
        labelDocumento.textContent = 'Número de documento de identificación'
    }
}

function checkTipoDocumento(tipoDocumento) {

    let selectTipoPersona = document.getElementById('usuario_persona_attributes_tipo_persona_id')

    if(selectTipoPersona.value == ''){ 
        alert('Debe selecionar un tipo de persona')
        tipoDocumento.value = ''
        return
    }

    let nDocumento = document.getElementById('usuario_n_documento')
    let personaNaturalDocumento = [1, 2]
    let personaJuridicaDocumento = [3]

    if (selectTipoPersona.value == 1) {
        if (!personaNaturalDocumento.includes(parseInt(tipoDocumento.value))) {
            alert('El tipo de persona natural no puede usar este tipo de documento')
            tipoDocumento.value = 1
            nDocumento.value = ''
        }
    } else {
        if (!personaJuridicaDocumento.includes(parseInt(tipoDocumento.value))) {
            alert('El tipo de persona juridica no puede usar este tipo de documento')
            tipoDocumento.value = 3
            nDocumento.value = ''
        }
    }
}