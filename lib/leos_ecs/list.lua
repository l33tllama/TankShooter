-- Very simple linked list with add, remove and clear
local List = {}

function List.new()
  return {next = nil}
end

function List.add(list, item_to_add)
  list = {next = list, item = item_to_add}
end

function List.remove(list, item_to_rm)
  local l = list
  local p = { next = nil, item = nil}
  
  while l do
    if l.item == item_to_rm then
      p.next = l.next
    end
    p = l
    l = l.next
  end
end

function List.callClassFunction(list, func, args)
  l = list
  while l do
    if l.item then
      l.item:func(args)
    end
    l = l.next
  end
end

function List.clear(list)
  list = {next = nil}
end

return List