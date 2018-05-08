namespace :paperclip do
  task migrate: :environment do
    klass = User
    attachment = 'avatar'
    name_field = :"#{attachment}_file_name"

    klass.where.not(name_field => nil).find_each do |instance|
      # This step helps us catch any attachments we might have uploaded that
      # don't have an explicit file extension in the filename

      filename = instance.send("#{attachment}_file_name")

      next if filename.blank?

      id = instance.id
      id_partition = ("%09d".freeze % id).scan(/\d{3}/).join("/".freeze)

      url = "https://nyc3.digitaloceanspaces.com/gorails/#{klass.table_name}/#{attachment.pluralize}/#{id_partition}/original/#{filename}"

      instance.send(attachment.to_sym).attach(
        io: open(url),
        filename: instance.send(name_field),
        content_type: instance.send(:"#{attachment}_content_type")
      )
    end
  end
end
