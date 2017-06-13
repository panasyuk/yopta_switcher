module DriverAdapterInterface
  def test_respond_to_visit
    assert_respond_to adapter, :visit
  end

  def test_respond_to_fill_in
    assert_respond_to adapter, :fill_in
  end

  def test_respond_to_wait
    assert_respond_to adapter, :wait
  end

  def test_respond_to_find_element
    assert_respond_to adapter, :find_element
  end

  def test_respond_to_click
    assert_respond_to adapter, :click
  end

  def test_respond_to_submit
    assert_respond_to adapter, :submit
  end

  def test_respond_to_clear
    assert_respond_to adapter, :clear
  end
end
