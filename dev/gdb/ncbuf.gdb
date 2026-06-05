define ncb_dump
  set $b = $arg0

  set $p = $b.area + ($b.head - 4)
  if ($p < $b.area)
    $p += $b.size
  end

  set $st = $p
  set $d = *(int *)$p

  printf " [ %d ]", $d

  set $p += 4
  if ($d > 0)
    set $p += $d
  end
  if ($p >= $b.area + $b.size)
    set $p -= $b.size
  end

  if ($p == $st)
    printf "\n"
  end

  while ($p != $st)
    if ($p < $st && $st - $p < 8)
      printf " -> *%d*\n", $st - $p
      loop_break
    end

    set $g = *(int *)($p)
    set $d = *(int *)($p + 4)

    printf " -> *%d*\n", $g
    if ($d)
      printf " [ %d ]", $d
    end

    set $p = (char *)$p + $g + $d
    if ($p >= $b.area + $b.size)
      set $p -= $b.size
    end
  end
end
