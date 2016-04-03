module UserAvatarUploader
  attr_writer :avatar

  def avatar
    avatar_path ? "/system/#{avatar_path}" : '/missing.png'
  end

  def store_avatar
    return unless avatar_valid?
    delete_avatar unless avatar_path.nil?
    make_store_dir
    write_file
    update_column :avatar_path, avatar_img
  end

  def delete_store_dir
    FileUtils.rm_rf Rails.root.join "public/system/users/#{id}"
  end

  private

  def avatar_valid?
    true if @avatar && @avatar.content_type.match(/.(png|jpg|jpeg)$/)
  end

  def avatar_img
    "/users/#{id}/#{@avatar.original_filename}"
  end

  def store_dir
    "public/system/users/#{id}"
  end

  def make_store_dir
    FileUtils.mkdir_p store_dir
  end

  def write_file
    File.open(
      Rails.root.join(store_dir, @avatar.original_filename), 'wb'
    ) { |file| file.write @avatar.tempfile.read }
  end

  def delete_avatar
    FileUtils.rm "public/system#{avatar_path}", force: true
  end
end
