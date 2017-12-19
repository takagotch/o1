
path = Rails.root.join('scanner/spec')
Dir.glob("#{path}/**/*_spec.r/**/*_spec.rbb") do |file|
	require file
end
