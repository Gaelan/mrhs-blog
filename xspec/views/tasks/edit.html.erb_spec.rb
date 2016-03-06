require 'rails_helper'

RSpec.describe 'tasks/edit', type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(
                            title: 'MyString',
                            body: 'MyText',
                            category: 1,
                            time_required: 1
    ))
  end

  it 'renders the edit task form' do
    render

    assert_select 'form[action=?][method=?]', task_path(@task), 'post' do
      assert_select 'input#task_title[name=?]', 'task[title]'

      assert_select 'textarea#task_body[name=?]', 'task[body]'

      assert_select 'input#task_category[name=?]', 'task[category]'

      assert_select 'input#task_time_required[name=?]', 'task[time_required]'
    end
  end
end
