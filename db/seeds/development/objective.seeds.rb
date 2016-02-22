# Seed Objective and Strand tables in development environment.
#
# bin/rails db:seed

Objective.create group: "A", name: "Knowing and understanding", description: "Through the study of theorists and practitioners of the arts, students discover the aesthetics of art forms and are able to analyse and communicate in specialized language. Using explicit and tacit knowledge alongside an understanding of the role of the arts in a global context, students inform their work and artistic perspectives."

Strand.create objective_id: 1, number: 1, label: 'knowledge & understanding', description: 'demonstrate knowledge and understanding of the art form studied, including concepts, processes, and the use of subject-specific terminology'
Strand.create objective_id: 1, number: 2, label: 'role of art form', description: 'demonstrate understanding of the role of the art form in original or displaced contexts'
Strand.create objective_id: 1, number: 3, label: 'inform artistic decisions', description: 'use acquired knowledge to purposefully inform artistic decisions in the process of creating artwork'
