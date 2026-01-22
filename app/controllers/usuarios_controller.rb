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
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      redirect_to new_usuario_path, notice: "Usuario creado"
    else
      
      Rails.logger.debug "ERRORES USUARIO: #{@usuario.errors.full_messages}"
      Rails.logger.debug "ERRORES PERSONA: #{@usuario.persona.errors.full_messages if @usuario.persona}"

      tablas_dependientes
      flash.now[:alert] = "Error al registrar el usuario"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
    tablas_dependientes
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update(usuario_params_edit)
      redirect_to edit_usuario_path, notice: "Usuario editado"
    else
      
      Rails.logger.debug "ERRORES USUARIO: #{@usuario.errors.full_messages}"
      Rails.logger.debug "ERRORES PERSONA: #{@usuario.persona.errors.full_messages if @usuario.persona}"

      tablas_dependientes
      flash.now[:alert] = "Error al editar el usuario"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    redirect_to usuario_path, notice: "Usuario eliminado."
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
  
end
