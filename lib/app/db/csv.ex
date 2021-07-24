defmodule App.DB.CSV do
  alias Mix.Shell.IO, as: Shell
  alias App.CLI.Menu
  alias App.CLI.Contacts
  alias NimbleCSV.RFC4180, as: CSVParser


  def perform(chose_menu_item) do
    case chose_menu_item do
      %Menu{ id: :create, label: _ } -> create()
      %Menu{ id: :read, label: _ } -> read()
      %Menu{ id: :update, label: _ } -> update()
      %Menu{ id: :delete, label: _ } -> delete()
    end
    App.CLI.Menu.Choice.start()
  end

  defp update do
    Shell.cmd("clear")

    prompt_message("Digite o email do amigo que deseja atualizar:")
    |> search_contact_by_email()
    |> check_contact_found()
    |> confirm()
    |> do_update()
  end

  defp do_update(contact) do
    case contact do
      :error ->
        Shell.info("Ok, o contato NÃO será excluído...")
        Shell.prompt("Pressione ENTER para continuar...")

      _->
        Shell.cmd("clear")
        Shell.info("Agora você irá digitar os novos dados do seu contato...")

        updated_contact = collect_data()

        get_struct_list_from_csv()
        |> delete_contact_from_struct_list(contact)
        |> contact_list_to_csv
        |> prepare_list_to_save_csv
        |> save_csv_file()

        updated_contact
        |> transform_on_wrapped_list()
        |> prepare_list_to_save_csv()
        |> save_csv_file([:append])

        Shell.info("Contato atualizado com sucesso!")
        Shell.prompt("Pressione ENTER para continuar")
    end
  end

  defp delete do
    Shell.cmd("clear")

    prompt_message("Digite o email do contato a ser excluido:")
    |> search_contact_by_email()
    |> check_contact_found()
    |> confirm()
    |> delete_and_save()
  end

  defp search_contact_by_email(email) do
    get_struct_list_from_csv()
    |> Enum.find(:not_found, fn list ->
      list.email == email
    end)
  end

  defp check_contact_found(contact) do
    case contact do
      :not_found ->
        Shell.cmd("clear")
        Shell.error("Amigo não encontrado!")
        Shell.prompt("Pressione ENTER para continuar...")
        App.CLI.Menu.Choice.start()

      _ -> contact
    end
  end

  defp confirm(contact) do
    Shell.cmd("clear")
    Shell.error("Encontramos...")

    show_contact(contact)

    case Shell.yes?("Deseja realmente apagar esse contato da lista?") do
      true -> contact
      false ->  :error
    end
  end

  defp show_contact(contact) do
    contact
    |> Scribe.print(data: [{"Nome", :name}, {"Email", :email}, {"Telefone", :phone}])
  end

  defp delete_and_save(contact) do
    case contact do
      :error ->
        Shell.info("Ok, o contato NÃO será excluído...")
        Shell.prompt("Pressione ENTER para continuar...")
      _ ->
        get_struct_list_from_csv()
        |> delete_contact_from_struct_list(contact)
        |> contact_list_to_csv()
        |> prepare_list_to_save_csv()
        |> save_csv_file()
    end
  end

  defp delete_contact_from_struct_list(list, contact) do
    list
    |> Enum.reject( fn elem -> elem.email == contact.email end)
  end

  defp contact_list_to_csv(list) do
    list
    |> Enum.map( fn item ->
      [item.email, item.name, item.phone]
    end)
  end

  defp read do
    get_struct_list_from_csv()
    |> show_contacts()
  end

  defp get_struct_list_from_csv do
    read_csv_file()
    |> parse_csv_file_to_list()
    |> csv_list_to_contacts_struct_list()
  end

  defp read_csv_file do
    Application.fetch_env!(:estudo_linguagem_funcional, :csv_file_path )
    |> File.read!()
  end

  defp csv_list_to_contacts_struct_list(list) do
    list
    |> Enum.map( fn [email, name ,phone] ->
      %Contacts{name: name, email: email, phone: phone}
    end)
  end

  defp parse_csv_file_to_list(csv_file) do
    csv_file
    |> CSVParser.parse_string(header: false)
  end

  defp show_contacts(contacts_list) do
    contacts_list
    |> Scribe.console(data: [{"Nome", :name}, {"Email", :email}, {"Telefone", :phone}])
  end

  defp create do
    collect_data()
    |> transform_on_wrapped_list()
    |> prepare_list_to_save_csv()
    |> save_csv_file([:append])
  end

  defp collect_data do
    Shell.cmd("clear")
    %Contacts{
      name: prompt_message("Digite o nome:"),
      email: prompt_message("Digite o email:"),
      phone: prompt_message("Digite o número:")
    }
  end

  defp prompt_message(message) do
    Shell.prompt(message)
    |>String.trim
  end

  defp transform_on_wrapped_list(struct) do
    struct
    |> Map.from_struct
    |> Map.values
    |> wrap_in_list
  end

  defp wrap_in_list (list) do
    [list]
  end

  defp prepare_list_to_save_csv(list) do
    list
    |> CSVParser.dump_to_iodata
  end

  defp save_csv_file(data, mode \\ []) do
    Application.fetch_env!(:estudo_linguagem_funcional, :csv_file_path )
    |> File.write!(data, mode)
  end
end
