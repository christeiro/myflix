Fabricator(:futurama) do
  title "Futurama"
  description "Description of the Futurama video"
  small_cover_url "/tmp/futurama.jpg"
  large_cover_url "/tmp/futurama.jpg"
  category { Fabricate(:cartoons) }
end