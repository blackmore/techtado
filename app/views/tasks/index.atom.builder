atom_feed do |feed|
  feed.title("Tech-tado")
  feed.updated(@tasks.first.created_at)
  
  @tasks.each do |task|
    feed.entry(task) do |entry|
      entry.title(task.description)
    end
  end
end