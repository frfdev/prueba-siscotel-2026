class UsuariosController < ApplicationController
  def index
    @usuarios = Usuario.all
  end

  def new
    @usuario = Usuario.new
  end

  def show
    @usuario = Usuario.find(params[:id])
  end

  def create
    @usuario = Usuario.new(usuario_params)
    if @usuario.save
      redirect_to @usuario, notice: "Usuario creador"
    else
      render :new
    end
  end

  def edit
    @usuario = Usuario.find(params[:id])
  end

  def update
    @usuario = Usuario.find(params[:id])
    if @usuario.update(usuario_params)
      redirect_to @usuario, notice: "Usuario Actualizado"
    else
      render :edit
    end
  end

  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy
    redirect_to usuario_path, notice: "Usuario eliminado."
  end

  private

  def usuario_params
    params.require(:usuario).permit(:n_documento, :tipo_documento_id, :persona_id, :fecha_emision, :fecha_vencimiento)
  end

end
