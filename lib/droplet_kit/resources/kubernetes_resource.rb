module DropletKit
  class KubernetesResource < ResourceKit::Resource
    include ErrorHandlingResourcable

    resources do
      action :all, 'GET /v2/kubernetes/clusters' do
        query_keys :per_page, :page, :tag_name
        handler(200) { |response| KubernetesMapping.extract_collection(response.body, :read) }
      end

      action :find, 'GET /v2/kubernetes/clusters/:id' do
        handler(200) { |response| KubernetesMapping.extract_single(response.body, :read) }
      end

      action :create, 'POST /v2/kubernetes/clusters' do
        body { |object| KubernetesMapping.representation_for(:create, object) }
        handler(201) { |response, cluster| KubernetesMapping.extract_into_object(cluster, response.body, :read) }
        handler(422) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end

      action :config, 'GET /v2/kubernetes/clusters/:id/kubeconfig' do
        handler(200) { |response| response.body }
      end

      action :update, 'PUT /v2/kubernetes/clusters/:id' do
        body { |cluster| KubernetesMapping.representation_for(:update, cluster) }
        handler(202) { |response| KubernetesMapping.extract_single(response.body, :read) }
        handler(422) { |response| ErrorMapping.fail_with(FailedUpdate, response.body) }
      end

      action :upgrade, 'GET /v2/kubernetes/clusters/:cluster_id/upgrade' do
      end

      action :delete, 'DELETE /v2/kubernetes/clusters/:id' do
        handler(202) { |response| true }
      end

      action :cluster_node_pools, 'GET /v2/kubernetes/clusters/:id/node_pools' do
        handler(200) { |response| KubernetesNodePoolMapping.extract_collection(response.body, :read) }
      end

      action :cluster_find_node_pool, 'GET /v2/kubernetes/clusters/:id/node_pools/:pool_id' do
        handler(200) { |response| KubernetesNodePoolMapping.extract_single(response.body, :read) }
      end

      action :cluster_node_pool_create, 'POST /v2/kubernetes/clusters/:id/node_pools' do
        body { |node_pool| KubernetesNodePoolMapping.representation_for(:create, node_pool) }
        handler(202) { |response| KubernetesNodePoolMapping.extract_single(response.body, :read) }
        handler(422) { |response| ErrorMapping.fail_with(FailedCreate, response.body) }
      end

      action :cluster_node_pool_update, 'PUT /v2/kubernetes/clusters/:id/node_pools/:pool_id' do
        body { |node_pool| KubernetesNodePoolMapping.representation_for(:update, node_pool) }
        handler(200) { |response| KubernetesNodePoolMapping.extract_single(response.body, :read) }
        handler(404) { |response| ErrorMapping.fail_with(FailedUpdate, response.body) }
      end

      action :cluster_node_pool_delete, 'DELETE /v2/kubernetes/clusters/:id/node_pools/:pool_id' do
        handler(202) { |response| true }
      end

      action :cluster_node_pool_recycle, 'POST /v2/kubernetes/clusters/:id/node_pools/:pool_id/recycle' do
        body { |node_ids| { nodes: node_ids }.to_json }
        handler(202) { |response| true }
        handler(404) { |response| ErrorMapping.fail_with(FailedUpdate, response.body) }
      end

      action :get_options, 'GET /v2/kubernetes/options' do
        handler(200) { |response| KubernetesOptionsMapping.extract_single(response.body, :read) }
      end
    end

    def all(*args)
      PaginatedResource.new(action(:all), self, *args)
    end
  end
end
