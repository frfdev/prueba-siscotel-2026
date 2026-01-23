class UsuariosController < ApplicationController
  def index
    if params[:q].present?
      
      q = "%#{params[:q]}%"

      @usuarios = Usuario
      .joins(:persona)
      .where("usuarios.n_documento LIKE ? OR personas.nombre LIKE ?", q, q)
    else
      @usuarios = Usuario.all
    end
    
  end

  def new
    @usuario = Usuario.new
    @usuario.build_persona
    tablas_dependientes
  end

  def show
    @usuario = Usuario.find(params[:id])
    tablas_dependientes
  end

  def create

    Rails.logger.debug "PARAMS: #{params.inspect}"
    
    @usuario = Usuario.new(usuario_params)

    nombre = params[:usuario][:persona_attributes][:nombre]
    
    tipo_persona = params[:usuario][:persona_attributes][:tipo_persona_id].to_i
    
    if tipo_persona == 1
      
      nombre_split = nombre.split(' ')
      
      if nombre_split.size < 2
        return errors_formulario("Debe ingresar al menos nombre y apellido")
      end
      
    elsif tipo_persona == 2

      if Persona.exists?(nombre: nombre.to_s.downcase)
        return errors_formulario("Ya existe el nombre de esta empresa")
      end

    end

    correo = params[:usuario][:persona_attributes][:correo].to_s.downcase

    if correo.blank? || !correo.include?("@")
      return errors_formulario("Formato de correo no válido")
    end

    correo_split = correo.split("@")

    if !correo_split[1]&.include?(".")
      return errors_formulario("Formato de correo no válido")
    end

    unless correo_split[0].match?(/\A[a-zA-Z0-9_-]+\z/)
      return errors_formulario("El correo solo puede tener letras, números, - y _ antes del @")
    end

    if correo_split[1]&.include?(".")
      
      host = correo_split[1].split('.')[0]
      tld = correo_split[1].split('.')[1]

      if ["gmail", "outlook", "hotmail"].include?(host) && tld != 'com'
          return errors_formulario("El formato del dominio del correo no es valido")
      elsif host == 'yahoo' && tld != 'es'
          return errors_formulario("El formato del dominio del correo no es valido")
      end

    end

    fecha_emision = params[:usuario][:fecha_emision]
    fecha_vencimiento = params[:usuario][:fecha_vencimiento]

    ano_emision = fecha_emision.split('-')[0]
    ano_vencimiento = fecha_vencimiento.split('-')[0]

    if ano_emision == ano_vencimiento
      return errors_formulario("El año de la fecha de vencimiento no puede ser igual a la de emision")
    end

    fecha_emision = Date.parse(fecha_emision) rescue nil
    fecha_vencimiento = Date.parse(fecha_vencimiento) rescue nil

    Rails.logger.debug "fecha emision: #{fecha_emision.to_s.downcase}"
    Rails.logger.debug "fecha vencimiento: #{fecha_vencimiento.to_s.downcase}"

    if fecha_emision.present? && fecha_vencimiento.present? && fecha_emision > fecha_vencimiento
      return errors_formulario("La fecha de emisión no puede ser mayor que la fecha de vencimiento")
    end

    n_documento = params[:usuario][:n_documento]

    if Usuario.exists?(n_documento: n_documento)
      return errors_formulario("Ya existe un usuario con este numero de identificacion")
    end

    if @usuario.save
      redirect_to new_usuario_path, notice: "Usuario creado"
    else
      errors_formulario("Error al registrar el usuario")
    end
  end


  def edit
    @usuario = Usuario.find(params[:id])
    tablas_dependientes
  end

  def update
    Rails.logger.debug "PARAMS: #{params.inspect}"
    
    @usuario = Usuario.find(params[:id])

    nombre = params[:usuario][:persona_attributes][:nombre]
    
    tipo_persona = params[:usuario][:persona_attributes][:tipo_persona_id].to_i
    
    if tipo_persona == 1
      
      nombre_split = nombre.split(' ')
      
      if nombre_split.size < 2
        return errors_formulario("Debe ingresar al menos nombre y apellido")
      end
      
    elsif tipo_persona == 2

      if Persona.exists?(nombre: nombre.to_s.downcase)
        return errors_formulario("Ya existe el nombre de esta empresa")
      end

    end

    correo = params[:usuario][:persona_attributes][:correo].to_s.downcase

    if correo.blank? || !correo.include?("@")
      return errors_formulario("Formato de correo no válido", :edit)
    end

    correo_split = correo.split("@")

    if !correo_split[1]&.include?(".")
      return errors_formulario("Formato de correo no válido", :edit)
    end

    unless correo_split[0].match?(/\A[a-zA-Z0-9_-]+\z/)
      return errors_formulario("El correo solo puede tener letras, números, - y _ antes del @", :edit)
    end

    if correo_split[1]&.include?(".")
      
      host = correo_split[1].split('.')[0]
      tld = correo_split[1].split('.')[1]

      if ["gmail", "outlook", "hotmail"].include?(host) && tld != 'com'
          return errors_formulario("El formato del dominio del correo no es valido", :edit)
      elsif host == 'yahoo' && tld != 'es'
          return errors_formulario("El formato del dominio del correo no es valido", :edit)
      end

    end

    fecha_emision = params[:usuario][:fecha_emision]
    fecha_vencimiento = params[:usuario][:fecha_vencimiento]

    ano_emision = fecha_emision.split('-')[0]
    ano_vencimiento = fecha_vencimiento.split('-')[0]

    if ano_emision == ano_vencimiento
      return errors_formulario("El año de la fecha de vencimiento no puede ser igual a la de emision", :edit)
    end

    fecha_emision = Date.parse(fecha_emision) rescue nil
    fecha_vencimiento = Date.parse(fecha_vencimiento) rescue nil

    Rails.logger.debug "fecha emision: #{fecha_emision.to_s.downcase}"
    Rails.logger.debug "fecha vencimiento: #{fecha_vencimiento.to_s.downcase}"

    if fecha_emision.present? && fecha_vencimiento.present? && fecha_emision > fecha_vencimiento
      return errors_formulario("La fecha de emisión no puede ser mayor que la fecha de vencimiento", :edit)
    end


    if @usuario.update(usuario_params_edit)
      redirect_to usuarios_path, notice: "Usuario editado"
    else
      
      Rails.logger.debug "ERRORES USUARIO: #{@usuario.errors.full_messages}"
      Rails.logger.debug "ERRORES PERSONA: #{@usuario.persona.errors.full_messages if @usuario.persona}"

      errors_formulario("Error al editar el usuario", :edit)
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    redirect_to usuarios_path, notice: "Usuario eliminado."
  end

  private

  def usuario_params
    params.require(:usuario).permit(
      :n_documento, 
      :tipo_documento_id, 
      :persona_id, 
      :fecha_emision, 
      :fecha_vencimiento,
      persona_attributes: [
        :nombre, :correo, :telefono_principal, :telefono_secundario, :tipo_persona_id
      ]
    )
  end

  def usuario_params_edit
    params.require(:usuario).permit(
      :n_documento,
      :tipo_documento_id,
      :fecha_emision,
      :fecha_vencimiento,
      persona_attributes: [
        :id,
        :nombre,
        :correo,
        :telefono_principal,
        :telefono_secundario,
        :tipo_persona_id
      ]
    )
  end

  def tablas_dependientes
    @tipo_persona = TipoPersona.all
    @tipo_documento = TipoDocumento.all
  end

  def errors_formulario(msg, vista = :new)
    @usuario.build_persona if @usuario.persona.nil?
    tablas_dependientes
    flash.now[:alert] = msg
    render vista, status: :unprocessable_entity
  end
  
end
