require 'rails_helper'

describe 'routing' do
  example 'staff top page' do
    expect(get: 'http://baukis.example.com').to route_to(
      host: 'baukis.example.com',
      controller: 'staff/top',
      action: 'index'
    )
  end

  example 'administrator login form' do
    expect(get: 'http://baukis.example.com/admin/login').to route_to(
      host: 'baukis.example.com',
      controller: 'admin/sessions',
      action: 'new'
    )
  end

  example 'customer top page' do
    expect(get: 'http://baukis.example.com/mypage').to route_to(
      host: 'baukis.example.com',
      controller: 'customer/top',
      action: 'index'
    )
  end

  example 'Given other host_name, to errors/not_fount' do
    expect(get: 'http://foo.example.jp').to route_to(
      controller: 'errors',
      action: 'routing_error'
    )
  end

  example 'Given unknown host_name, to errors/not_fount' do
    expect(get: 'http://baukis.example.com/xyz').to route_to(
      controller: 'errors',
      action: 'routing_error',
      anything: 'xyz'
    )
  end
end
  
