require 'test_helper'
include SessionsHelper

class RoomControllerTest < ActionDispatch::IntegrationTest

  def setup
    @member = Member.create(name: 'matheus',
                          email: 'matheus@gmail.com',
                          password: '123456',
                          password_confirmation: '123456',
                          alias: 'mateusin')
    @another_member = Member.create(name: 'vitor',
                            email: 'vitor@gmail.com',
                            password: '123456',
                            password_confirmation: '123456',
                            alias: 'vitor')

    sign_in_as @member

    @room = Room.create(name: 'teste', description: 'teste2', owner: @member)
    @topic = Topic.create(name: 'SomeTopic', description: 'somedescription', room: @room)
  end

  test "should get index" do
    get member_rooms_path(@member)
    assert_response :success
  end

  test "should not get index if not logged in" do
    sign_out_as @member
    get member_rooms_path(@member)
    assert_redirected_to root_path
  end

  test "should show room" do
    get "/rooms/#{@room.id}"
    assert_response :success
  end

  test "should get new" do
    get new_member_room_path(@member)
    assert_response :success
  end

  test "should not get new if not logged in" do
    sign_out_as @member
    get new_member_room_path(@member)
    assert_redirected_to root_path
  end

  test "should create room" do
    post  "/members/#{@member.id}/rooms", params: {
      room: {
        name: "teste",
        description: "testedescription"
      },
      member_id: @member.id
    }

    room = Room.last

    assert_redirected_to room_path(room)
  end

  test "should not create room when missing name" do
    post "/members/#{@member.id}/rooms/", params: { room: { name: '' } }
    assert_redirected_to new_member_room_path(@member)
  end

  test "should get edit room" do
    get edit_room_path(@room)
    assert_response :success
  end

  test "should update room" do
    name_old = @room.name
    patch "/rooms/#{@room.id}", params: {room: { name: "teste2" } }
    @room.reload

    assert_not_equal name_old, @room.name
    assert_redirected_to "/rooms/#{@room.id}"
  end

  test "should not edit room with wrong params" do
    patch "/rooms/#{@room.id}", params: {room: { name: "" } }

    assert_equal "Error updating room", flash[:alert]
  end

  test "should destroy room" do
    assert_difference('Room.count', -1) do
      delete "/rooms/#{@room.id}"
      assert_redirected_to  member_rooms_path(@member)
    end
  end

  test "should user be in room's black_list if owner bans him" do
    @another_member.rooms << @room
    @another_member.save

    post "/topics/#{@topic.id}/ban_member", params: {member_id: @another_member.id, topic_id: @topic.id}
    @room.reload

    assert @room.black_list.include? @another_member.id
  end

  test "should user not be banned by another regular user" do
      @member3 = Member.create(name: 'matheusss', email: 'matheusss@gmail.com', password: '12345678', password_confirmation: '12345678', alias: 'mateussisn')
      @another_member.rooms << @room
      @member3.rooms << @room
      @another_member.save
      @member3.save
      sign_out_as @member
      sign_in_as @another_member
      post "/topics/#{@topic.id}/ban_member", params: {member_id: @member3.id, topic_id: @topic.id}
      @room.reload

      assert_not @room.black_list.include? @member3.id
  end

  test "should member not enter room if he is in it's blacklist" do
    @another_member.rooms << @room
    post "/topics/#{@topic.id}/ban_member", params: {member_id: @another_member.id, topic_id: @topic.id}
    sign_out_as @member
    sign_in_as @another_member
    post "/rooms/signup", params: {id: @room.id}

    assert_equal "You are not allowed to join this room", flash[:notice]
    assert_not @room.members.include? @another_member
  end

  test "should member enter room if he is reintegrated" do
    @another_member = Member.create(name: 'matheuss', email: 'matheuss@gmail.com', password: '123456', password_confirmation: '123456', alias: 'mateusisn')
    @another_member.rooms << @room

    post "/topics/#{@topic.id}/ban_member", params: {
      member_id: @another_member.id
    }

    post "/rooms/#{@room.id}/reintegrate_member", params: {
      member_id: @another_member.id
    }

    sign_out_as @member
    sign_in_as @another_member

    post "/rooms/signup", params: {
      id: @room.id
    }

    assert @room.members.include? @another_member
  end

  test "should user be able to join room" do
    sign_out_as @member
    sign_in_as @another_member

    post "/rooms/signup", params: {
      id: @room.id
    }

    assert @room.members.include? @another_member
    assert @another_member.rooms.include? @room
  end

  test "should user not be able to join room if he is already joined" do
    sign_out_as @member
    sign_in_as @another_member

    post "/rooms/signup", params: {
      id: @room.id
    }

    assert @room.members.include? @another_member
    assert @another_member.rooms.include? @room

    # trying to enter twice
    post "/rooms/signup", params: {
      id: @room.id
    }

    assert "You are already registered in this room", flash[:notice]
  end

  test "should user exits room" do
    sign_out_as @member
    sign_in_as @another_member

    post "/rooms/signup", params: {
      id: @room.id
    }

    assert @room.members.include? @another_member
    assert @another_member.rooms.include? @room

    post "/rooms/signout", params: {
      id: @room.id
    }

    @room.reload
    @another_member.reload

    assert_not @room.members.include? @another_member
    assert_not @another_member.rooms.include? @room
    assert_redirected_to room_path(@room)
  end

  test "should user cannot exit room if he is not joined in it" do
    sign_out_as @member
    sign_in_as @another_member

    post "/rooms/signout", params: {
      id: @room.id
    }

    @room.reload
    @another_member.reload

    assert_not @room.members.include? @another_member
    assert_not @another_member.rooms.include? @room
    assert "You are not registered in this room", flash[:notice]
    assert_redirected_to room_path(@room)
  end

  test "should get members list from room" do
    get "/rooms/#{@room.id}/members_list"
    assert_response :success
  end

  test "should ban member from members list" do
    post "/topics/#{@topic.id}/ban_member", params: {
      member_id: @another_member.id,
      room_id: @room.id
    }

    @room.reload
    assert @room.black_list.include?(@another_member.id)
    assert_redirected_to members_list_path(@room)
  end

  test "should room owner get banned members page" do
    get "/rooms/#{@room.id}/banned_members"

    assert_response :success
  end

  test "should regular member not be able to access banned members page" do
    sign_out_as @member
    sign_in_as @another_member

    get "/rooms/#{@room.id}/banned_members"

    assert_redirected_to room_path(@room)
    assert_equal "You do not have permission to do this action", flash[:notice]
  end

  test "should user cannot be banned twice" do
    @another_member.rooms << @room
    @another_member.save

    post "/topics/#{@topic.id}/ban_member", params: { member_id: @another_member.id, topic_id: @topic.id }
    @room.reload

    assert @room.black_list.include? @another_member.id

    # trying to ban member twice
    post "/topics/#{@topic.id}/ban_member", params: { member_id: @another_member.id, topic_id: @topic.id }

    assert "The member is already banned", flash[:notice]
  end

  test "should reintegrate member from blacklist" do
    @another_member.rooms << @room
    @another_member.save

    @room.black_list << @another_member.id
    @room.save

    post "/rooms/#{@room.id}/reintegrate_member", params: { member_id: @another_member.id }

    @room.reload

    assert_redirected_to banned_members_url(@room)
    assert_not @room.black_list.include? @another_member.id
    assert_equal "Member has been removed from black list and can now join the room", flash[:notice]
  end

  test "should not reintegrate member from blacklist if not owner" do
    @another_member.rooms << @room
    @another_member.save

    @room.black_list << @another_member.id
    @room.save

    sign_out_as @member
    sign_in_as @another_member

    post "/rooms/#{@room.id}/reintegrate_member", params: { member_id: @another_member.id }

    assert_redirected_to room_path(@room)
    assert @room.black_list.include? @another_member.id
  end

end
