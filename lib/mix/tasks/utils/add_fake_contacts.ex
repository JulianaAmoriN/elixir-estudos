defmodule Mix.Tasks.AddFakeContacts do
  use Mix.Task
  alias App.CLI.Contacts
  alias NimbleCSV.RFC4180, as: CSVParser

  @shortdoc "Add fake contacts on App"
  def run(_) do
    Faker.start()

    create_contacts([], 10)
    |> CSVParser.dump_to_iodata
    |> save_csv_file

    IO.puts "Amigos gerados com sucesso"
  end

  defp create_contacts(list, count) when count <= 1 do
    list ++ [ramdon_list_contacts()]
  end

  defp create_contacts(list, count) do
    list ++ [ramdon_list_contacts()] ++ create_contacts(list, count - 1)
  end

  defp ramdon_list_contacts do
    %Contacts{
      name: Faker.Person.PtBr.name(),
      email: Faker.Internet.free_email(),
      phone: Faker.Phone.EnUs.phone()
    }
    |> Map.from_struct()
    |> Map.values
  end

  defp save_csv_file(data) do
    Application.fetch_env!(:estudo_linguagem_funcional, :csv_file_path)
    |> File.write!(data, [:append])
  end
end
