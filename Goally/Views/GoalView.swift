//
//  GoalView.swift
//  NanoChallenge2
//
//  Created by Minawati on 21/07/22.
//

import SwiftUI
import SwipeableView

struct GoalView: View {
    
    @State var showAddGoalModal = false
    @State var showEditGoalModal = false
    @State private var showDeleteAlert = false
    
    @State var selectedGoal: Goals
    @StateObject private var goalListViewModel = GoalListViewModel()
    
    var body: some View {
        
        NavigationView {
            ScrollView { 
                VStack(alignment: .leading) {
                    
                    Text(goalListViewModel.goals.count == 0 ? "No goals are waiting for you today" : "\(goalListViewModel.goals.count) goals are waiting for you today")
                        .font(.system(size: 14, weight: .semibold))
                        .padding(.bottom, 23)
                        .padding(.leading, 20)
                    
                    Spacer()
                    
                    if (goalListViewModel.goals.count == 0) {
                        
                        Image("No-Goals")
                            .resizable()
                            .scaledToFit()
                            .padding(.top, 38)
                            .frame(width: UIScreen.screenWidth, height: 317)
        
                        Text("You've no goals")
                            .font(.system(size: 18, weight: .bold))
                            .padding(.bottom, 6)
                            .frame(width: UIScreen.screenWidth, alignment: .center)
        
                        Text("Add new goal and start progressing")
                            .font(.system(size: 12))
                            .padding(.bottom, 6)
                            .frame(width: UIScreen.screenWidth, alignment: .center)
                    
                    } else {
                        
                        ForEach(goalListViewModel.goals, id: \.self) { goal in
                            SwipeableView(
                                content: {
                                    NavigationLink(destination: GoalDetailView(goal: goal, selectedTask: Tasks(), deleteSelectedTask: Tasks())
                                        .navigationBarTitle(Text("Goal Detail"), displayMode: .inline)
                                    ){
                                        HStack {

                                            Text(goal.unwrappedEmoji)
                                                .font(.system(size: 40))
                                            
                                            VStack(alignment: .leading) {
                                                Text(goal.unwrappedTitle)
                                                    .font(.system(size: 15, weight: .bold, design: .default))
                                                    .foregroundColor(.black)
                                                
                                                HStack {
                                                    ProgressView(value: Double(Double(goal.progress)/100))
                                                        .tint(Color("LightBlue"))
                                                    
                                                    Text("\(goal.progress)%")
                                                        .font(.system(size: 12))
                                                        .padding(.bottom, 4)
                                                        .foregroundColor(Color("DarkGray"))
                                                }
                                            }
                                            .padding(.leading, 10)
                                            
                                            Spacer()
                                        }
                                        .onAppear {
                                            goalListViewModel.getAllGoals()
                                        }
                                        .padding(.horizontal, 23)
                                        .frame(width: 352, height: 76, alignment: .center)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(Color("LightGray"), lineWidth: 1)

                                        )
                                        .padding(.bottom, 7)
                                    }
                                },
                                leftActions:
                                    [Action(title: "Edit", iconName: "pencil", bgColor: Color("DarkBlue"), action: {
                                         editAction(goal: goal)
                                    }),
                                     Action(title: "Delete", iconName: "trash", bgColor: Color("DarkRed"), action: {
                                        deleteAction(goal: goal)
                                    })],
                                rightActions: [],
                                rounded: true)
                            .frame(height: 76)
                        }
                        .padding(.bottom, 10)
                    }
                    
                    Spacer()
                }
                .navigationTitle("Your Goals")
                .navigationBarItems(trailing:
                    Button(action: {
                        self.showAddGoalModal.toggle()
                    }) {
                        Image(systemName: "plus")
                            .foregroundColor(Color("DarkBlue"))
                    }
                )
            }
        }
        .onAppear {
            goalListViewModel.getAllGoals()
        }
        .sheet(isPresented: $showAddGoalModal) {
            AddGoalView(showModal: self.$showAddGoalModal).environmentObject(goalListViewModel)
        }
        .sheet(isPresented: $showEditGoalModal) {
            EditGoalView(showEditGoalModal: self.$showEditGoalModal, goals: $selectedGoal).environmentObject(goalListViewModel)
        }
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete the goal?"),
                message: Text("Once you delete, your goal will be deleted"),
                primaryButton: .cancel (
                    Text("Cancel"),
                    action: {
                        self.showDeleteAlert.toggle()
                    }
                ),
                secondaryButton: .destructive (
                    Text("Delete"),
                    action: {
                        withAnimation {
                            goalListViewModel.deleteGoal(goal: selectedGoal)
                        }
                    }
                )
            )
        }
    }
    
    private func deleteAction(goal: Goals){
        self.selectedGoal = goal
        self.showDeleteAlert.toggle()
    }
    
    private func editAction(goal: Goals){
        self.selectedGoal = goal
        self.showEditGoalModal.toggle()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        GoalView(selectedGoal: Goals())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
