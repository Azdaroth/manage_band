class AssetSerializer < ActiveModel::Serializer

  delegate :id, :name, :tag_list, to: :object

  attributes :item, :children

  def item
    {
      id: id,
      name: name,
      file_url: file_url,
      tag_list: tag_list,
      asset_attachment_id: asset_attachment_id
    }
  end

  def children
    object.assets.map { |asset| AssetSerializer.new(asset, root: false) }
  end

  def asset_attachment_id
    if object.attachment
      object.attachment.id
    end
  end

  def file_url
    if object.attachment
      ENV["HOST"] + object.attachment.file.url
    end
  end


end