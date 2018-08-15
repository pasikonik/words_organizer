defmodule ListProcessor do
  @default_dir "~/Downloads/"
  @max_lines 50

  def standart_list(file_path) do
    new_list = get_path(file_path)
      |> File.read!
      |> String.split(~r{\r\n|\r|\n})
      |> Enum.map(fn line -> prepare_line(line) end)

    file_amount = round(Float.ceil(length(new_list) / @max_lines))
    lists = Enum.chunk_every(new_list, @max_lines)

    lists
      |> Enum.with_index
      |> Enum.each(fn({list, i}) ->
        ready_list = Enum.join(list, "\n")
        new_list_path = get_path("new_list_#{i+1}.csv")
        File.write(new_list_path, ready_list)
     end)

    IO.puts "created #{file_amount} lists"
  end

  defp prepare_line(line) do
    String.split(line, ",")
      |> get_pair()
      |> Enum.join(",")
  end

  defp get_pair(line_array) do
    direction = Enum.take(line_array, 2)
    raw_pair = Enum.take(line_array, -2)
    pair = Enum.map(raw_pair, &String.downcase/1)

    case direction do
      ["angielski", "polski"] ->
        pair
      ["polski", "angielski"] ->
        Enum.reverse(pair)
      _ ->
        raise 'unsupported languages'
    end
  end

  defp get_path(file_name) do
    Path.expand("#{@default_dir}#{file_name}")
  end
end

ListProcessor.standart_list("list.csv")
