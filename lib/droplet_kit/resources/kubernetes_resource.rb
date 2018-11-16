module DropletKit
  class KubernetesResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      action :all, 'GET /v2/kubernetes/clusters' do
        handler(200) { |response| KubernetesMapping.extract_collection(response.body, :read) }
      end

      action :find, 'GET /v2/kubernetes/clusters/:cluster_id' do
      end

      action :create, 'POST /v2/kubernetes/clusters' do
      end

      action :config, 'GET /v2/kubernetes/clusters/:cluster_id/kubeconfig' do
      end

      action :update, 'PUT /v2/kubernetes/clusters/:cluster_id' do
      end

      action :upgrade, 'GET /v2/kubernetes/clusters/:cluster_id/upgrade' do
      end

      action :delete, 'DELETE /v2/kubernetes/clusters/:cluster_id' do
      end

      action :all_node_pools, 'GET /v2/kubernetes/clusters/:cluster_id/node_pools' do
      end

      action :find_node_pool, 'GET /v2/kubernetes/clusters/:cluster_id/node_pools/:pool_id' do
      end

      action :create_node_pool, 'POST /v2/kubernetes/clusters/:cluster_id/node_pools' do
      end

      action :update_node_pool, 'PUT /v2/kubernetes/clusters/:cluster_id/node_pools/:pool_id' do
      end

      action :delete_node_pool, 'DELETE /v2/kubernetes/clusters/:cluster_id/node_pools/:pool_id' do
      end

      action :recycle_node_pool, 'POST /v2/kubernetes/clusters/:cluster_id/node_pools/:pool_id/recycle' do
      end

      action :get_options, 'GET /v2/kubernetes/options' do
      end
    end

  end
end
