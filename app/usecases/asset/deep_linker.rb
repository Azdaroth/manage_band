class Asset::DeepLinker

  attr_reader :scope
  private     :scope

  def initialize(scope)
    @scope = scope
  end

  def link(tree_params)
    deep_link(nil, tree_params)
  end

  private

    def deep_link(root, tree_params = {})
      tree_params.each_with_index do |asset_aggregate, idx|
        asset = scope.assets.find(asset_aggregate["item"]["id"])
        asset.position = idx
        asset.asset = root
        asset.save!
        if asset_aggregate["children"].present?
          deep_link(asset, Array.wrap(asset_aggregate["children"]))
        end
      end
    end

end