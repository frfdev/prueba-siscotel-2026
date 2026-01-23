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
        tipoDocumento.value = ''
        return
    }
    
    let personaNaturalDocumento = [1, 2]
    let personaJuridicaDocumento = [3]

    if (selectTipoPersona.value == 1) {
        if (!personaNaturalDocumento.includes(parseInt(tipoDocumento.value))) {
            alert('El tipo de persona natural no puede usar este tipo de documento')
            tipoDocumento.value = 1
        }
    } else {
        if (!personaJuridicaDocumento.includes(parseInt(tipoDocumento.value))) {
            alert('El tipo de persona juridica no puede usar este tipo de documento')
            tipoDocumento.value = 3
        }
    }
}

document.addEventListener("turbo:load", () => {
    let tipoPersonaSelect = document.getElementById('usuario_persona_attributes_tipo_persona_id')
    let tipoDocumentoSelect = document.getElementById('usuario_tipo_documento_id')

    if (tipoPersonaSelect && tipoDocumentoSelect) {
        checkTipoPersona(tipoPersonaSelect.value)
        checkTipoDocumento(tipoDocumentoSelect)

        tipoPersonaSelect.addEventListener("change", () => {
            checkTipoPersona(tipoPersonaSelect.value)
            checkTipoDocumento(tipoDocumentoSelect)
        })

        tipoDocumentoSelect.addEventListener("change", () => {
            checkTipoDocumento(tipoDocumentoSelect)
        })
    }
})