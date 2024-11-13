mp.add_hook('on_load', 10, function()
    local sub_paths = { 'Subs', 'subtitles', 'subs', 'sub' }
    sub_paths[#sub_paths + 1] = 'Subs/' .. mp.get_property('filename/no-ext')
    mp.set_property_native('sub-file-paths', sub_paths)
end)
