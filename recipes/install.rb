#
# Cookbook Name:: kapacitor
# Recipe:: install
#
# Copyright 2015, Virender Khatri
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

case node['platform_family']
when 'debian'
  # apt repository configuration
  apt_repository 'influxdb' do
    uri node['kapacitor']['apt']['uri']
    components node['kapacitor']['apt']['components']
    key node['kapacitor']['apt']['key']
    distribution node['lsb']['codename']
    action node['kapacitor']['apt']['action']
  end
when 'rhel'
  # yum repository configuration
  yum_repository 'influxdb' do
    description node['kapacitor']['yum']['description']
    baseurl node['kapacitor']['yum']['baseurl']
    gpgcheck node['kapacitor']['yum']['gpgcheck']
    gpgkey node['kapacitor']['yum']['gpgkey']
    enabled node['kapacitor']['yum']['enabled']
    action node['kapacitor']['yum']['action']
  end
end

package 'kapacitor' do
  version node['kapacitor']['version'] if node['kapacitor']['version']
  notifies :restart, 'service[kapacitor]' if node['kapacitor']['notify_restart'] && !node['kapacitor']['disable_service']
end
