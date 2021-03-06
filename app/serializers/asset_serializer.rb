class AssetSerializer < ActiveModel::Serializer

  delegate :id, :name, to: :object

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
    object.assets_by_position.map { |asset| AssetSerializer.new(asset, root: false) }
  end

  def asset_attachment_id
    if object.attachment
      object.attachment.id
    end
  end

  def tag_list
    object.tags.map(&:name)
  end

  def file_url
    if object.attachment
      ENV["HOST"] + object.attachment.file.url
    end
  end


end