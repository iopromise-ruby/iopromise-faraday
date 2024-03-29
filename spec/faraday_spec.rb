# frozen_string_literal: true

require 'iopromise/faraday'

RSpec.describe IOPromise::Faraday do
  it "returns a pending promise for a get request" do
    conn = IOPromise::Faraday.new(
      url: "https://github.com/"
    )
    
    p = conn.get('/status')
    expect(p).to be_pending
  end

  it "returns a promise that completes the request on sync" do
    conn = IOPromise::Faraday.new(
      url: "https://github.com/"
    )
    
    p = conn.get('/status')
    p.sync
    expect(p).to be_fulfilled
    expect(p.value).to be_success
    expect(p.value.body).to include('GitHub lives!')
  end

  it "allows for chaining to a promise and sync works up the chain" do
    conn = IOPromise::Faraday.new(
      url: "https://github.com/"
    )
    
    p = conn.get('/status').then do |result|
      result.body.gsub('GitHub', 'OctoCat')
    end
    p.sync
    expect(p).to be_fulfilled
    expect(p.value).to include('OctoCat lives!')
  end

  it "fulfills promises for failures with a non-successful response" do
    conn = IOPromise::Faraday.new(
      url: "https://invalid.url.example/"
    )
    
    p = conn.get('/status')
    p.sync
    expect(p).to be_fulfilled
    expect(p.value).to_not be_success
  end

  it "runs multiple requests" do
    conn = IOPromise::Faraday.new(
      url: "https://github.com/"
    )
    
    promises = (1..3).map do
      conn.get('/status')
    end

    promises.each do |promise|
      expect(promise).to be_pending
    end

    Promise.all(promises).then do |results|
      expect(results.length).to eq(3)
      expect(results.select { |r| r.body.include? 'GitHub lives' }.length).to eq(3)
    end.sync

    promises.each do |promise|
      expect(promise).to be_fulfilled
    end
  end

  it "supports all Faraday supported verbs" do
    conn = IOPromise::Faraday.new(
      url: "https://github.com/"
    )
    
    (::Faraday::METHODS_WITH_QUERY + ::Faraday::METHODS_WITH_BODY).each do |method|
      promise = conn.send(method, '/status')
      expect(promise).to be_pending
    end
  end
end
