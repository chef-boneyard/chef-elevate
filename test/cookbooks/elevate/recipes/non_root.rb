elevate "bash -c 'echo as_root > /tmp/as_root'"

elevate "bash -c 'echo as_nobody > /tmp/as_nobody'" do
  user 'nobody'
end

elevate "bash -c 'echo as_group_nobody > /tmp/as_group_nobody'" do
  user 'nobody'
  group 'nobody'
end

elevate "bash -c 'echo $WOOT > /tmp/with_env'" do
  env('WOOT' => 'COW')
end
