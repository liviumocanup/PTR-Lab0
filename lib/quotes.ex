defmodule Quotes do
  @url "https://quotes.toscrape.com/"

  defp get_request() do
    HTTPoison.get!(@url)
  end

  def init do
    response = get_request()

    print_response(response)

    quotes = extract_quotes(response.body)

    write_to_file(quotes)
  end

  defp print_response(response) do
    IO.puts("Response status_code : #{response.status_code}")
    IO.inspect(response.headers, label: "Response headers")
    IO.puts("Response body : #{response.body}")
  end

  defp extract_quotes(body) do
    {:ok, html} = Floki.parse_document(body)
    quotes = Floki.find(html, ".quote")
    Enum.map(quotes, fn quote ->
      author = extract_author(quote)
      text = extract_text(quote)
      tags = extract_tags(quote)
      IO.inspect(%{author: author, text: text, tags: tags})
    end)
  end

  defp write_to_file(quotes) do
    File.write!("quotes.json", Jason.encode!(quotes))
  end

  defp extract_author(quote) do
    Floki.find(quote, ".author") |> hd() |> Floki.text()
  end

  defp extract_text(quote) do
    Floki.find(quote, ".text") |> hd() |> Floki.text()
  end

  defp extract_tags(quote) do
    Floki.find(quote, ".tag") |> Enum.map(&Floki.text/1)
  end
end
